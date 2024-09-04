#!/bin/bash

echo "######################################"
echo "          Website Assignment           "
echo "          Date: 06/24/2024             "
echo "######################################"

echo "Installing Nginx"
# sudo apt-get update
# sudo apt-get upgrade -y
# sudo apt-get install nginx -y
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y  # Non-interactive update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nginx  # Non-interactive Nginx install
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Downloading website"
wget https://github.com/ceeepath/project-templates/archive/refs/tags/website_1.0.0.tar.gz

echo "Install tar"
sudo apt install tar -y
tar -xzvf website_1.0.0.tar.gz
cd project-templates-website_1.0.0

tar -xvf template01.tar.gz
cd template01

echo "Deploying website"
sudo rm /var/www/html/index.html
sudo mv index index.html
sudo mv index.html /var/www/html/
sudo cp -r * /var/www/html/

echo "Allowing Permission"
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

echo "Restarting Nginx"
sudo systemctl restart nginx

echo "Deployment successful"
