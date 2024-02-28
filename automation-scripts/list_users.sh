#!/bin/bash

# Before running the script -> sudo apt install jq -y -> export username="<your-github-username>", export token="<your-access-token>"

# GitHub API URL
API_URL="https://api.github.com"

# GitHub Username and Personal Access Token
USERNAME=$username 
TOKEN=$token 

# User and Repository Information
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
github_api_get() {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with Authentication
    curl -s -u "${USERNAME}:${TOKEN}" "${url}"
}

list_user_with_read_access() {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi         
}


# Main Script
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_user_with_read_access