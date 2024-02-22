#!/bin/bash
set -e

# Function to check CPU usage
check_cpu() {
    echo "Checking CPU usage..."
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
    echo "CPU Usage: $cpu_usage%"
}

# Function to check available memory
check_memory() {
    echo "Checking available memory..."
    free_memory=$(free -m | awk '/Mem:/ {print $4}')
    echo "Free Memory: ${free_memory}MB"
}

# Function to check disk space
check_disk() {
    echo "Checking disk space..."
    disk_space=$(df -h / | awk '/\// {print $4}')
    echo "Available Disk Space: $disk_space"
}

# Function to check system uptime
check_uptime() {
    echo "Checking system uptime..."
    uptime=$(uptime -p)
    echo "System Uptime: $uptime"
}

# Function to check network connectivity
check_network() {
    echo "Checking network connectivity..."
    ping -c 3 google.com > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "Network is up."
    else
        echo "Network is down."
    fi
}

# Main function
main() {
    echo "Health Check Script"
    echo "-------------------"
    
    check_cpu
    check_memory
    check_disk
    check_uptime
    check_network

    echo "-------------------"
    echo "Health check complete."
}

# Run the main function
main

