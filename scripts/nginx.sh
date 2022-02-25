#!/bin/bash
sudo apt-get update && apt-get install -y nginx
sudo systemctl start nginx.service
echo "Nginx installed successfully!"
sudo chown $USER /var/www/html
touch /var/www/html/index.html
echo "Hello World" > /var/www/html/index.html

uname -a >> /var/www/html/index.html
