#!/bin/bash
sudo dnf update -y
sudo dnf install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo echo 'server {
      listen 80;
      location / {
        proxy_pass http://${alb_dns_name};
      }
    }' | sudo tee /etc/nginx/conf.d/proxy.conf
sudo systemctl restart nginx