# Exercise 2: Launch an EC2 Instance and Install Nginx to Serve a Static Video

### Objective: 
Create an EC2 instance and use bash to install and configure the Nginx web server to serve a static video file.


### Requirements:

1. The EC2 instance should be created using an *Amazon Linux 2* AMI & *t2.micro* type.

2. The *Nginx* web server should be installed, running and configured to serve a static video file..

3. A custom Nginx configuration should be used to support video streaming.

4. Configure a security group to allow HTTP (port 80) and SSH (port 22) traffic.


### Tasks:
1. AWS Diagram:

    - Single EC2 instance.

    - Security group with inbound rules for HTTP and SSH.

    - VPC with one public subnet.


2. Create bash script that do the following:

    - Installs Nginx, starts the service, and configures it to start on boot.

    - Upload a sample video file (e.g., .mp4), and configure Nginx to serve the video from a specific URL path.

    - Update the Nginx configuration to include proper MIME types for video streaming.

    - Verify the installation by accessing the EC2 instance's public IP in a web browser using cURL.



### Deliverables:

- AWS diagram on PDF format

- Bash script used for installation

- URL/Screenshots showing the Nginx custom page
