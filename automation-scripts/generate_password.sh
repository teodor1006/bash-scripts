#!/bin/bash

# Function to generate a random password
generate_password() {
    tr -dc 'A-Za-z0-9!@#$%^&*()_+-=' < /dev/urandom | head -c 16
    echo
}

# Generate password and store it in a file
generate_password > passwords_generated.txt

echo "Password generated and stored in passwords_generated.txt"


