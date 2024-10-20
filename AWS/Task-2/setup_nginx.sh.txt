#!/bin/bash

# Update package list
sudo yum update -y

# Install Nginx
sudo yum install -y nginx

# Start Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Create a directory for the video if it doesn't exist
sudo mkdir -p /usr/share/nginx/html/videos

# Upload a sample video file (replace with your video URL or local file path)
# You can use wget to download a sample video
wget -O /usr/share/nginx/html/videos/sample.mp4 https://www.w3schools.com/html/mov_bbb.mp4

# Configure Nginx to serve video files
cat <<EOL | sudo tee /etc/nginx/conf.d/video.conf
server {
    listen 80;
    server_name localhost;

    location /videos/ {
        root /usr/share/nginx/html;
        add_header Content-Type video/mp4;
        add_header Accept-Ranges bytes;
        add_header Cache-Control no-cache;
        # Add more headers as needed for video streaming
    }

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
}
EOL

# Test Nginx configuration
sudo nginx -t

# Restart Nginx to apply changes
sudo systemctl restart nginx

echo "Nginx installation and configuration completed."
