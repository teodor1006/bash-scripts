#!/bin/bash

echo "Welcome to the Bash Timer!"

read -p "Enter the time in seconds: " time_interval

# Check if the input is a positive integer
if ! [[ "$time_interval" =~ ^[0-9]+$ ]]; then
    echo "Error: Please enter a positive integer"
    exit 1
fi

# Display a confirmation message to the user
echo "Timer set for $time_interval seconds. Press Ctrl+C to stop the timer."

sleep "$time_interval"

echo "Timer expired! Time's up!"

