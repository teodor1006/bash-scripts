#!/bin/bash

# Define a function to check the status of a website
check_website() {
    local url="$1"
    local response

    # Use curl to get the HTTP status code
    response=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    # Check the HTTP status code and provide appropriate output
    if [ "$response" -eq 200 ]; then
        echo "Website $url is up and running!"
    else
        echo "Website $url is down or unreachable (HTTP status code: $response)."
    fi
}

# Call the function with a sample website
check_website "https://www.youtube.com"
