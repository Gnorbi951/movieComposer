
#!/bin/bash


while  [[ ! -f "picture/intro.mp4" ]];
do
    echo "What is the name of the intro picture?(please include .png)"
    echo "Available files:";
    ls picture | grep "\.png";
    read intro
    if [ -f "picture/"$intro ];
    then
        bash picture/convert_png_to_mp4.sh "picture/"$intro "picture/intro.mp4";
        bash join_movies.sh;
    else
        echo "picture/"$intro" not found"
fi
done

while  [[ ! -f "picture/outro.mp4" ]];
do
    echo "What is the name of the outro picture?(please include .png)"
    echo "Available files:";
    ls picture | grep "\.png";
    read outro
    if [ -f "picture/"$outro ];
    then
        bash picture/convert_png_to_mp4.sh "picture/"$outro "picture/outro.mp4";
        bash join_movies.sh;
    else
        echo "picture/"$outro" not found"
fi
done


inotifywait -m ./input/ -e close_write -e delete |
    while read dir action file;
    do
        echo "'$action' action happend with '$file' in '$dir'";
        if [[ $file == *".mp4" ]];
            then
            bash join_movies.sh;
        fi
    done
