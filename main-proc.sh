#!/bin/bash

# Start filebrowser to serve the directory
filebrowser -r /add-spoof &
sleep 5

# Path to the directory containing torrent files
torrent_dir="/add-spoof"

# Infinite loop to continuously monitor the directory
while true; do
    # Loop through all torrent files in the directory
    for torrent_file in "$torrent_dir"/*.torrent; do
        # Check if there are any torrent files
        if [ -e "$torrent_file" ]; then
            filename=$(basename -- "$torrent_file")
            filename_no_ext="${filename%.*}"
            
            # Run the command for each torrent file using nohup
            nohup ./ratio-spoof -t "$torrent_file" -d 100% -ds 10kbps -u 1000tb -us 1000000mbps > /dev/null 2>&1 &
            echo "Started ratio-spoof for $filename_no_ext."
        fi
    done
    sleep 20  # Adjust the interval as needed
done
