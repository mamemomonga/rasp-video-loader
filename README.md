# Raspberry Pi で動画をブラウザからコントロール

Raspberry Piを使い動画を再生します。

ブラウザでファイルを選択でき、簡単な再生コントロールができます。

## 必要なもの

* Raspberry Pi Model B(ネットワーク接続が必要)
* Raspian

## やっておいたほうがいい設定

/boot/config.txtの調整

	disable_overscan=1
	gpu_mem=128

## インストール方法

	$ sudo aptitude install carton
	$ git clone https://github.com/mamemomonga/rasp-video-loader.git
	$ cd rasp-video-loader
	$ carton install

## 設定の調整

ビデオのある任意のフォルダに書き換えます。

	$ vim rasp-video-loader.pl
	my $video_dir='/home/pi/movie';

## 起動

起動時に指定フォルダの動画ファイルを検索します。

	$ ./start.sh

CTRL+Cで終了です。

	http://[Raspberry Piのアドレス]:3000/

にアクセスし、ファイル名をクリックします。

