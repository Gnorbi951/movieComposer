#! /bin/bash

echo "Which file do you want to convert to video? (please include .png)"
read file


if [ -f $file ]
then
    echo $file
    echo "How long do you want your video to be? (in seconds)"
    read len
    echo "What should be the name of your output file? (Include .mp4)"
    read out

    ffmpeg -loop 1 -i $file -c:v libx264 -t $len -pix_fmt yuv420p $out

else
    echo "$file doesn't exist"
fi