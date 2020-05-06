#!/bin/bash

#transcoding
ffmpeg -i input/input2.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts temp/temp1.ts
ffmpeg -i input/input1.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts temp/temp2.ts

#joining
ffmpeg -i "concat:temp/temp1.ts|temp/temp2.ts" -c copy -bsf:a aac_adtstoasc output/output.mp4 -y

#removing temp file
rm temp/*
