
#!/bin/bash
inotifywait -m ./input/ -e create -e moved_to -e modify |
    while read dir action file; do
        echo "The file '$file' appeared in directory '$dir' via '$action'";
        if [[ $file == *".mp4" ]]; then # Does the file end with .mp4?
            echo "mp4 file" # If so, do your thing here!
        fi
        # do something with the file
    done
