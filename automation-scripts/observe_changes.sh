#!/bin/bash

# Make sure to have inotifywait installed before running the script

# Directory to watch (default: user's home directory)
dir_to_watch="$HOME"

# Time in seconds to observe changes (default: 300 seconds)
observation_period=300

# Log file to store changes
log_file="changes.log"

# Function to observe changes in the directory
observe_changes() {
    inotifywait -r -m -e modify,create,delete,move "$dir_to_watch" |
    while read -r directory event file; do
        echo "$(date +"%Y-%m-%d %H:%M:%S") - Event: $event - File: $directory$file" >> "$log_file"
    done
}

# Check if the directory exists
if [ ! -d "$dir_to_watch" ]; then
    echo "Error: The directory $dir_to_watch does not exist." >&2
    exit 1
fi

# Output configuration information
echo "Observing changes in directory: $dir_to_watch"
echo "Observation period: $observation_period seconds"

# Execute the function to observe changes in the directory
observe_changes &

# Waiting for observation time
sleep "$observation_period"

# End the observation after the observation time
trap 'cleanup' EXIT
cleanup() {
    echo "Observation completed. Changes have been recorded in $log_file."
    echo "Cleaning up..."
    pkill -P $$ inotifywait
}
