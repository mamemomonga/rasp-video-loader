#!/usr/bin/env perl
use utf8;
use Mojolicious::Lite;
use File::Find;
use Mojo::Util qw(b64_encode b64_decode);

# データディレクトリ(最後に / が必要)
my $video_dir='/home/pi/movie/';

pipe(my $readh,my $writeh);
select($writeh); $|=1; select(STDOUT);

say "search";
my @filelist=();
{

	my @fl;
	find(sub { push @fl,$File::Find::name },$video_dir);
	foreach(@fl) {
		next unless /\.(mo4|mov|avi|m2ts|mkv|mp3|wav|wma|cda|ogg|ogm|aac|ac3|flac)$/;
		next if -d $_;

		s#^\Q$video_dir\E##; #

		my $title=$_;
		utf8::decode($title);

		my $etitle=b64_encode($_);
		$etitle=~s/\n//g;

		push @filelist,[$title,$etitle];
	}
	@filelist=sort { $a->[0] cmp $b->[0] } @filelist;
}
say "ready";

get '/' => sub {
	my $c = shift;
	$c->stash('filelist',\@filelist);
	$c->render('index');
};

get '/-play/(*filepath)' => sub {
	my $c=shift;
	my $filename=b64_decode($c->stash('filepath'));

	if(my $pid=fork()) {
		$c->redirect_to('/');

	} elsif(defined $pid) {
		system('killall','/usr/bin/omxplayer.bin');
		open STDIN,'<&=',fileno($readh);
		exec('omxplayer',"$video_dir/$filename");
		warn('exec failed');
	} else {
		warn('fork failed');
	}
};

get '/-control/(:command)' => sub {
	my $c=shift;
	my @commands=(qw( 1 2 j k i o n m s q p - + ),'left','right','down','up');
	my %keycodes=(
		'right' => "\e[C",
		'left'  => "\e[D",
		'down'  => "\e[B",
		'up'    => "\e[A",
	);
	my $rcom=$c->stash('command');
	my $command;
	foreach(@commands) {$command=$_ if ($rcom eq $_) }
	$command=$keycodes{$command} if $keycodes{$command};
	unless($command) {
		$c->render('text'=>'error');
		return;
	}
	print $writeh $command;
	$c->render('text'=>'success');
};

app->start;
