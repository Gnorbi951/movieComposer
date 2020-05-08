#! /bin/bash

file=$1;
out=$2;

if [ -f $file ]
then
    echo $file
    echo "How long do you want your video to be? (in seconds)"
    read len
    ffmpeg -loop 1 -i $file -c:v libx264 -t $len -pix_fmt yuv420p $out -loglevel warning

else
    echo "$file doesn't exist"
fi
