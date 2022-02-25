#!/bin/bash
sudo apt-get update && apt-get install -y nginx
sudo systemctl start nginx.service
echo "Nginx installed successfully!"
sudo chown $USER /var/www/html
touch /var/www/html/index.html
echo "Hello World" > /var/www/html/index.html

OS_INFO=$(cat /etc/os-release)

echo $OS_INFO >> /var/www/html/index.html

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo usermod -aG docker $USER 
sudo chmod 777 /var/run/docker.sock