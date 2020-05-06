#! /bin/bash

#transcoding
counter=0
path="temp/temp"
extension=".ts"
for filename in ./input/*.mp4;
do
    final_path=$path$counter$extension
    ffmpeg -i $filename -c copy -bsf:v h264_mp4toannexb -f mpegts $final_path -y
    ((counter++))
done

#joining
concat_param="concat:"
path=""
counter=0
for file in ./temp/*.ts;
do
    correct_file_path=""
    IFS='/' # hyphen (/) is set as delimiter
    read -ra ADDR <<< "$file" # str is read into an array as tokens separated by IFS
    word_counter=0
    for i in "${ADDR[@]}";
    do # access each element of array
        if (($word_counter==1 || $word_counter==3))
        then
            correct_file_path=$correct_file_path$i
        elif (($word_counter==2))
        then
            correct_file_path="${correct_file_path}/$i"
        fi
        ((word_counter++))
    done
    IFS=' ' # reset to default value after usage
    echo $correct_file_path
    if ((counter == 0))
    then
        path="${path}$correct_file_path"
    else
        path="${path}|$correct_file_path"
    fi
    ((counter++))
done
final_path="concat:${path}"
echo $final_path
 ffmpeg -i $final_path -c copy -bsf:a aac_adtstoasc output/output.mp4 -y

#removing temp file
#rm temp/*
