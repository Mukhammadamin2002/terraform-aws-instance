#!/bin/bash
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker $USER 
sudo chmod 777 /var/run/docker.sock