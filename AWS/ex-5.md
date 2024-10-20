# Exercise 5: Automate the Installation of Docker and Deploy an Application Behind Nginx as a Reverse Proxy

### Objective: 
Set up an EC2 instance with Docker and Nginx. Deploy a containerized application, with Nginx acting as a reverse proxy for the Docker container.



### Requirements:

1. The EC2 instance should use Amazon Linux 2 and t2.medium.

2. Docker CE should be installed and running on the instance.

3. A 2 sample web application (e.g., a simple Python Flask app or nginx & apache ) should be deployed in a Docker containers.

3. Nginx should be installed and configured as a reverse proxy to route traffic to the Docker containers.

4. The security group should allow HTTP (port 80), the application's port (if different), and SSH (port 22) traffic.

### Tasks:

1. AWS Diagram:

    - Single EC2 instance

    - Nginx as a reverse proxy

    - Docker running a containerized application

    - Security group with inbound rules for HTTP, the application's port, and SSH



2. Linux Task:

    - Write a bash script that installs Docker and Nginx.

    - Deploy a containerized web application (such as a Python Flask app running on port 5000) using Docker.

    - Configure Nginx as a reverse proxy to forward requests from port 80 to the application's port inside the Docker container.

    - Verify the setup by accessing the application through the EC2 instance's public IP.



### Deliverables:

- AWS diagram on PDF format

- Bash script for Docker and Nginx installation, container deployment, and Nginx configuration

- URL/Screenshots showing the application being accessed through Nginx
