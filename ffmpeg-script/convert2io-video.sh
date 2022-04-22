#!/bin/sh

read -p "Device [ io5 | io7 | io10 ]? " DEVICE

if [ "$DEVICE" = "io5" ];
then
    SCALE="-2:480"
    SIZE="854:480"
    CC="colorchannelmixer=1:0:0:0:0:0.9:0:0:0:0:0.85:0"

elif [ "$DEVICE" = "io7" ];
then
    SCALE="-2:576"
    SIZE="1024:576"
    CC="colorchannelmixer=1:0:0:0:0:0.85:0:0:0:0:0.78:0"

elif [ "$DEVICE" = "io10" ];
then
    SCALE="-2:576"
    SIZE="1024:576"
    CC="eq=contrast=1:saturation=1.2:brightness=-0.03, colorchannelmixer=0.7:0.05:0:0: 0:0.7:0:0: 0:0:0.6:0"
else

    echo "Wrong input > $DEVICE"
    echo usage: sh convert2io-video.sh INPUTFILE
    exit; 

fi

ffmpeg -stream_loop 70 -i $1 -vf "scale=${SCALE}, pad=${SIZE}:(iw-ow)/2:(iw-ow)/2, fps=30, ${CC}" -crf 10 -y -pix_fmt yuv420p ${1}.${DEVICE}.out.mp4

