#!/bin/bash

# Backup destination directory
backup_dir="/path/to/backup"

# Directories and files to backup
backup_sources=(
    "/path/to/source1"
    "/path/to/source2"
    "/path/to/source3/file.txt"
)

# Create a timestamp for the backup file
timestamp=$(date +"%Y%m%d_%H%M%S")

# Create the backup archive
backup_filename="backup_$timestamp.tar.gz"
backup_path="$backup_dir/$backup_filename"

# Check if the backup directory exists, if not, create it
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi

# Perform the backup using tar
tar -czvf "$backup_path" "${backup_sources[@]}"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup successful. Archive saved to: $backup_path"
else
    echo "Backup failed."
fi

