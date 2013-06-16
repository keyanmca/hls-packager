#!/bin/sh
while true;do
PLISTEN=8000
FF=/usr/local/ffmpeg/bin/ffmpeg
######
HLSDIR=/data/media/c1
[ ! -d $STDIR ] && mkdir -p $HLSDIR
PFILE=main.list
LASTID=$(tail -1 $HLSDIR/$PFILE 2>/dev/null|\
awk -F'/' '{print$NF}'|cut -f1 -d'.')
if [ -z $LASTID ];then 
 LASTID=$(date +%s)
else
 LASTID=$(bc -q<<<$LASTID+1)
fi
#############
 nc -l $PLISTEN|\
 $FF -i - -c copy -map 0 -threads 0 -f segment -segment_list $HLSDIR/$PFILE -segment_list_type flat \
 -segment_start_number $LASTID -segment_time 5 -segment_list_size 5 -segment_format mpegts $HLSDIR/%10d.ts
done
