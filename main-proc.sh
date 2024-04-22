filebrowser -r /add-spoof &

torrent_dir="/add-spoof"
while true; do
    # Loop through all torrent files in the directory
    for torrent_file in "$torrent_dir"/*.torrent; do
        # Extract filename without extension
        filename=$(basename -- "$torrent_file")
        filename_no_ext="${filename%.*}"
        
        # Run the command for each torrent file using nohup
        nohup ./ratio-spoof -t "$torrent_file" -d 100% -ds 10kbps -u 1000tb -us 1000000mbps > /dev/null 2>&1 &
        
        # Print a message indicating that the command has been started
        echo "Started ratio-spoof for $filename_no_ext."
        
        # Optional: You may want to move or delete the torrent file after processing it
        # mv "$torrent_file" /path/to/destination/   # Move the file to a different directory
        # rm "$torrent_file"                         # Delete the file
    done
    
    # Sleep for a while before checking the directory again
    sleep 20  # Adjust the interval as needed
done

