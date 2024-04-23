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
            nohup ./ratio-spoof -t "$torrent_file" -d 100% -ds 10kbps -u 1000tb -us 1000000mbps > /dev/null 2>&1 &
            
            # Wait for a moment to allow the process to start
            sleep 5
            
            # Check if the ratio-spoof process is running
            if ps -ef | grep -Fq "./ratio-spoof -t $torrent_file"; then
                # If the process is running, write "OK" status to the log file
                echo "$filename_no_ext:  STARTED OK" >> "$status_file"
            else
                # If the process is not running, write "NOT OK" status to the log file
                echo "$filename_no_ext: NOT OK" >> "$status_file"
            fi
            
            # Print a message indicating that the command has been started
            echo "Started ratio-spoof for $filename_no_ext."
            rm "$torrent_file"
        fi
    done
    check_process_status
    # Sleep for a while before checking the directory again
    sleep 20  # Adjust the interval as needed
done
