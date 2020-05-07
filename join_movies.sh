#! /bin/bash

#transcoding
#input directory
counter=0
path="temp/temp"
extension=".ts"
for filename in ./input/*.mp4;
do
    final_path=$path$counter$extension
    ffmpeg -i $filename -c copy -bsf:v h264_mp4toannexb -f mpegts $final_path -y
    ((counter++))
done

#picture directory
if [ -f ./picture/intro.mp4 ]
then
    ffmpeg -i ./picture/intro.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts temp/a.ts
fi
if [ -f ./picture/outro.mp4 ]
then
ffmpeg -i ./picture/outro.mp4 -c copy -bsf:v h264_mp4toannexb -f mpegts temp/z.ts
fi
#a and z for being first and last files

#joining
path=""
counter=0
for file in ./temp/*.ts;
do
    correct_file_path=""
    IFS='/' # hyphen (/) is set as delimiter
    read -ra ADDR <<< "$file" # file is read into an array as tokens separated by IFS
    word_counter=0

    for i in "${ADDR[@]}";
    do
        # If it is the 2. or 4. element simply append
        if (($word_counter==1 || $word_counter==3))
        then
            correct_file_path=$correct_file_path$i
        
        # If it is the 3. element add a / so the path will be correct
        elif (($word_counter==2))
        then
            correct_file_path="${correct_file_path}/$i"
        fi
        ((word_counter++))
    done

    IFS=' ' # reset to default value after usage

    #if this is the 1. word, don't add a pipe so the output will be concat:temp/file1.ts|temp/file2.ts
    if ((counter == 0))
    then
        path="${path}$correct_file_path"
    else
        path="${path}|$correct_file_path"
    fi
    ((counter++))
done
final_path="concat:${path}"
ffmpeg -i $final_path -c copy -bsf:a aac_adtstoasc output/output.mp4 -y

#removing temp file
rm temp/*
