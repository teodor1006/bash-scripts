#!/bin/bash

# Directory to backup
backup_dir="/path/to/your/directory"

# Destination directory for backups
backup_dest="/path/to/backup/destination"

# Create a timestamp for the backup file
timestamp=$(date +"%Y%m%d_%H%M%S")

# Name of the backup file
backup_file="backup_$timestamp.tar.gz"

# Create backup
echo "Creating backup of $backup_dir..."

# Check if the backup directory exists, if not create it
if [ ! -d "$backup_dest" ]; then
    mkdir -p "$backup_dest"
fi

# Create the backup file
tar -czf "$backup_dest/$backup_file" "$backup_dir"

if [ $? -eq 0 ]; then
    echo "Backup created successfully: $backup_dest/$backup_file"
else
    echo "Backup creation failed!"
fi


