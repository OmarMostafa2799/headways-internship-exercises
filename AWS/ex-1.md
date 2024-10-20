# Exercise 1: Deploy a Static Website Using S3 and CloudFront

### Objective: 
Deploy a static website on AWS using S3 for storage and CloudFront for CDN.


### Requirements:

1. The website should be accessible worldwide.

2. It must be fast and cached using a CDN (CloudFront).

3. HTTPS should be used for secure access.

4. Logging should be enabled for S3 and CloudFront.

### Tasks:

1. Create AWS Diagram:

    - S3 bucket (for static website hosting)

    - CloudFront distribution (connected to the S3 bucket)


2. Create bash script that do the following:

    - Create an index.html file with custom content.
    - Upload that file to the S3 bucket using the AWS CLI from from your machine.

### Deliverables:

- AWS diagram on PDF format

- Bash script used for installation

- URL/Screenshots showing the website accessible via the CloudFront URL 
