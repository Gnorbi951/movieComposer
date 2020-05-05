#!/bin/bash

#transcoding
ffmpeg -i input2.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts temp1.ts
ffmpeg -i input1.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts temp2.ts

#joining
ffmpeg -i "concat:temp1.ts|temp2.ts" -c copy -bsf:a aac_adtstoasc output.mp4 -y

#removing temp file
rm temp1.ts
rm temp2.ts
