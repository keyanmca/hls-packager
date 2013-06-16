#!/bin/sh
SRVIP=10.0.0.10; SRVPORT=8000
FF=/usr/local/ffmpeg/bin/ffmpeg
$FF -re -i INPUT_FILE -c copy -f mpegts -|nc $SRVIP $SRVPORT
