# Raspberry Pi でブラウザでファイルを選んでテレビで動画再生

Raspberry Pi でブラウザでファイルを選んでテレビで動画再生させる簡易的なツールです。
簡単な再生コントロールができます。

## 必要なもの

* Raspberry Pi Model B(ネットワーク接続が必要)
* Raspian

## やっておいたほうがいい設定

/boot/config.txtの調整

	disable_overscan=1
	gpu_mem=128

参考: [Raspberry Pi ModelB+を買った](http://blog.mamemomonga.com/2015/01/raspberry-pi-modelb.html)

## インストール方法

	$ sudo aptitude install carton
	$ git clone https://github.com/mamemomonga/rasp-video-loader.git
	$ cd rasp-video-loader
	$ carton install

## 設定の調整

ビデオのある任意のフォルダに書き換えます。

	$ vim rasp-video-loader.pl
	my $video_dir='/home/pi/movie';

## 起動と使い方

以下のコマンドを実行します。

	$ ./start.sh

起動時に指定フォルダの動画ファイルを検索します。

	Server available at http://127.0.0.1:3000.

と表示されたら待機状態です。CTRL+Cで終了します。

	http://[Raspberry Piのアドレス]:3000/

にアクセスし、ファイル名をクリックします。

