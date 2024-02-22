#!/bin/bash

# Error handling
set -e
set -o pipefail

# Function to handle errors
handle_error() {
    echo "An error occurred. Exiting."
    exit 1
}

# Trap errors and call the function
trap 'handle_error' ERR

# Your script code goes here
echo "Executing the main script."

# Simulating an error
nonexistent_command

# This line will not be reached due to the error
echo "Script completed successfully."
