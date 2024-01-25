#!/bin/bash

# Define backup and source directories
backup_dir="/backup"
source_dir="/var/www/html"

# Create a backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Perform the backup using rsync
rsync -av "$source_dir" "$backup_dir"
