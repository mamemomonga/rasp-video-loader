#!/bin/sh
echo "loading"
exec carton exec -- ./rasp-video-loader.pl daemon
