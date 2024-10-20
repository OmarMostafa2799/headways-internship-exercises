# Exercise 3: Configure an Auto-Scaling Group with a Load Balancer

### Objective: 
Deploy an auto-scaling group that uses an Application Load Balancer (ALB) to distribute traffic.


### Requirements:

1. The system should automatically scale based on CPU usage.

2. The ALB should perform health checks on instances.

3. Use an Amazon Machine Image (AMI) for the instances that includes a simple web server.

### Tasks:

1. AWS Diagram:

    - ALB distributing traffic to the auto-scaling group

    - Auto-scaling group containing multiple EC2 instances



2. Linux Task:
    - Create a custom AMI from a Linux EC2 instance with a pre-installed web server (e.g., Nginx).

### Deliverables:

- AWS diagram on PDF format.
- Screenshots showing scaling in action.
- AMI ID and scaling policies for the auto-scaling group.
