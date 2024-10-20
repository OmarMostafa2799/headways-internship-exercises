#!/bin/bash

# Update the system
sudo yum update -y

# Install Docker
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker

# Add the ec2-user to the docker group
sudo usermod -aG docker ec2-user

# Install Nginx
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Create a sample Flask application
cat << 'EOF' > app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, World from Flask running in Docker!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

# Create a Dockerfile for the Flask application
cat << 'EOF' > Dockerfile
FROM python:3.8-slim
WORKDIR /app
COPY app.py .
RUN pip install Flask
CMD ["python", "app.py"]
EOF

# Build the Docker image
sudo docker build -t flask-app .

# Run the Docker container
sudo docker run -d -p 5000:5000 flask-app

# Configure Nginx as a reverse proxy
cat << 'EOF' | sudo tee /etc/nginx/conf.d/default.conf
server {
    listen 80;

    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

# Restart Nginx to apply the configuration
sudo systemctl restart nginx

echo "Setup complete. Access the application via http://18.215.246.152"
