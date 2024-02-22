#!/bin/bash

# Function to cleanup temporary files
clean_temp_files() {
    echo "Cleaning up temporary files..."
    sudo rm -rf /tmp/*
    sudo rm -rf /var/tmp/*
    echo "Temporary files cleaned up."
}

# Function to cleanup package caches
clean_package_caches() {
    echo "Cleaning up package caches..."
    sudo apt-get clean
    sudo apt-get autoclean
    sudo apt-get autoremove --purge -y
    echo "Package caches cleaned up."
}

# Function to cleanup old log files
clean_log_files() {
    echo "Cleaning up log files older than 7 days..."
    sudo find /var/log -type f -mtime +7 -exec rm -f {} \;
    echo "Old log files cleaned up." 
}

main() {
    clean_temp_files
    clean_package_caches
    clean_log_files
    echo "System cleanup complete."
}

# Call the main function
main
