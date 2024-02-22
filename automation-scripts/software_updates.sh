#!/bin/bash

# Update system packages
sudo apt update
sudo apt upgrade -y

# Update docker containers (if existing)
docker-compose -f /path/to/docker-compose.yaml pull
docker-compose -f /path/to/docker-compose.yaml up -d