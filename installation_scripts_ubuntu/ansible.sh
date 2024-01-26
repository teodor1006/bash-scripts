#!/bin/bash

sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install python-software-properties -y
sudo apt-get install -y ansible