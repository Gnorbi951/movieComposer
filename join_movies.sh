#! /bin/bash

#transcoding
counter=0
path="temp/temp"
extension=".ts"
for filename in ./input/*.mp4;
do
    final_path=$path$counter$extension
    ffmpeg -i $filename -c copy -bsf:v h264_mp4toannexb -f mpegts $final_path
    ((counter++))
done

#joining
#ffmpeg -i "concat:temp/temp1.ts|temp/temp2.ts|temp/temp3.ts" -c copy -bsf:a aac_adtstoasc output/output.mp4 -y

#removing temp file
#rm temp/*
