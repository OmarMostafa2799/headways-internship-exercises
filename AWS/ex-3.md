# Exercise 3: Deploy an EC2 Instance and Set Up a Prometheus Monitoring Server with Alertmanager, and Set Up Email Alerts Using AWS SES

### Objective: 
Launch an EC2 instance and use bash to install and configure Prometheus for monitoring, use Alertmanager to send email alerts via AWS Simple Email Service (SES)..


### Requirements:

1. The EC2 instance should be set up using *Ubuntu Server* AMI & *t2.micro* type.

2. *Prometheus* should be installed and accessible on port 9090.

3. Alertmanager should be set up to send email alerts through AWS SES when a metric threshold is breached (e.g., high CPU usage).

3. Configure a security group to allow Prometheus (port 9090), Alertmanager (port 9093) and SSH (port 22) access.

### Tasks:


1. AWS Diagram:

    - Single EC2 instance

    - Security group with inbound rules for Prometheus, Alermanger and SSH

    - AWS SES for sending email notifications

    - VPC with one public subnet.

2. Create bash script that do the following:

    - Download Prometheus, install it, and sets it up as a systemd service.

    - Integrate Alertmanager with AWS SES by setting up IAM permissions and configuring the SMTP settings.

    - Create a simple alert rule in Prometheus that triggers an email when CPU usage goes above a certain threshold.

    - Test the installation by accessing Prometheus through the EC2 instance's public IP on port 9090 using cURL.

    - Test the alert by simulating high CPU usage.



### Deliverables:

- AWS diagram on PDF format

- Bash script used for installation

- Configuration file

- URL/Screenshots showing the Prometheus web interface