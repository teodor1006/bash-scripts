#!/bin/bash

# Function to check and create user
create_user() {
    local username=$1

    if id "$username" &>/dev/null; then
        echo "User $username already exists."
    else
        # Create user
        sudo useradd "$username"
        
        # Set a password for the user
        sudo passwd "$username"
    fi
}

# Check and create User1
create_user "user1"

# Check and create User2
create_user "user2"

# Display the usernames
echo "User 1: user1"
echo "User 2: user2"
