#!/bin/bash

# Variables
BUCKET_NAME="gdfnfhfhnfghgd4343"  
REGION="eu-north-1"                      

# Create an S3 bucket
aws s3api create-bucket --bucket $BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION

# Enable static website hosting
aws s3 website s3://$BUCKET_NAME --index-document index.html --error-document error.html

# Create index.html
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to My Static Website</title>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>This is a static website hosted on AWS S3.</p>
</body>
</html>
EOF

# Upload index.html to S3 bucket
aws s3 cp index.html s3://$BUCKET_NAME/

# Set S3 bucket policy for public access
aws s3api put-bucket-policy --bucket $BUCKET_NAME --policy "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"s3:GetObject\",\"Resource\":\"arn:aws:s3:::$BUCKET_NAME/*\"}]}"


# Create CloudFront distribution
CLOUDFRONT_OUTPUT=$(aws cloudfront create-distribution --origin-domain-name $BUCKET_NAME.s3.amazonaws.com \
  --default-root-object index.html \
  --enabled \
  --comment "Distribution for $BUCKET_NAME" \
  --default-cache-behavior '{
    "TargetOriginId": "'$BUCKET_NAME'",
    "ViewerProtocolPolicy": "redirect-to-https",
    "AllowedMethods": ["GET", "HEAD"],
    "CachedMethods": ["GET", "HEAD"],
    "ForwardedValues": {
      "QueryString": false,
      "Cookies": {
        "Forward": "none"
      }
    },
    "MinTTL": 0,
    "DefaultTTL": 86400,
    "MaxTTL": 31536000
  }' \
  --origins '[
    {
      "Id": "'$BUCKET_NAME'",
      "DomainName": "'$BUCKET_NAME'.s3.amazonaws.com",
      "OriginPath": "",
      "CustomOriginConfig": {
        "HTTPPort": 80,
        "HTTPSPort": 443,
        "OriginProtocolPolicy": "https-only"
      }
    }
  ]' \
  --caller-reference "$(date +%s)"  # Unique value for CallerReference
)

echo "CloudFront Distribution created with ID: $(echo $CLOUDFRONT_OUTPUT | jq -r .Distribution.Id)"


# Enable logging for S3
aws s3api put-bucket-logging --bucket $BUCKET_NAME --bucket-logging-status '{"LoggingEnabled":{"TargetBucket":"your-log-bucket","TargetPrefix":"logs/"}}'  # Replace with your log bucket

# Enable logging for CloudFront
aws cloudfront update-distribution --id $CLOUDFRONT_ID --if-match $(aws cloudfront get-distribution --id $CLOUDFRONT_ID --query 'ETag' --output text) --distribution-config '{"Logging":{"Enabled":true,"IncludeCookies":false,"Bucket":"your-log-bucket.s3.amazonaws.com","Prefix":"cloudfront-logs/"}}'  # Replace with your log bucket

echo "S3 Bucket created: $BUCKET_NAME"
echo "CloudFront Distribution created with ID: $CLOUDFRONT_ID"
echo "Access your website at: https://$CLOUDFRONT_ID.cloudfront.net"
