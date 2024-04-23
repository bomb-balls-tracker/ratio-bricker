#!/bin/bash

# Start filebrowser to serve the directory
filebrowser -r /add-spoof &

# Wait for filebrowser to start
sleep 5

# Path to the directory containing torrent files
torrent_dir="/add-spoof"

# File to keep track of status
status_file="$torrent_dir/status.log"

# Create an empty status file if it doesn't exist
touch "$status_file"

# Infinite loop to continuously monitor the directory
while true; do
    # Loop through all torrent files in the directory
    for torrent_file in "$torrent_dir"/*.torrent; do
        # Check if the torrent file exists
        if [ -e "$torrent_file" ]; then
            # Extract filename without extension
            filename=$(basename -- "$torrent_file")
            filename_no_ext="${filename%.*}"
            
            # Check if the status log already contains a line for this file
            if grep -q "^$filename_no_ext: OK" "$status_file"; then
                # If the line exists, continue to the next file
                continue
            fi
            
            # Run the ratio-spoof command for the torrent file
            nohup ./ratio-spoof -t "$torrent_file" -d 100% -ds 10kbps -u 1000tb -us 1000000mbps > /dev/null 2>&1
            
            # Check if the ratio-spoof process was successful
            if [ $? -eq 0 ]; then
                # If successful, write a "OK" status message to the log file
                echo "$filename_no_ext: OK" >> "$status_file"
            else
                # If failed, write a "NOT OK" status message to the log file
                echo "$filename_no_ext: NOT OK" >> "$status_file"
            fi
            rm "$torrent_file"
        fi
    done
    
    # Sleep for a while before checking the directory again
    sleep 20  # Adjust the interval as needed
done
