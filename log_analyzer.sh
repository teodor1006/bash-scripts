#!/bin/bash

##################################################################################
# The script assumes the log file is named access.log, 
# The analyze_log function uses awk to extract the IP addresses from each line of the log file, sort them, and count the occurrences using uniq -c, and sorts them in descending order.
##################################################################################


logfile="access.log"

# Function to analyze the log file
analyze_log() {
    echo "Analyzing log file: $logfile"

    # Count the number of occurrences of each IP address in the log file
    awk '{print $1}' "$logfile" | sort | uniq -c | sort -rn
}

# Check if the log file exists
if [ -f "$logfile" ]; then
     analyze_log
else
     echo "Log file not found: $logfile"
fi           