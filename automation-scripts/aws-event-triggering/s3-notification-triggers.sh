#!/bin/bash

# Debug Mode
set -x

# Store the AWS Account in a variable
aws_account_id=$(aws sts get-caller-identity --query 'Account' --output text)
echo "AWS Account ID: $aws_account_id"

# Set AWS region and bucket name
aws_region="us-east-1"
bucket_name="teodor-bucket"
lambda_func_name="s3-lambda-function"
role_name="s3-lambda-sns"
email_address="sabr@gmail.com"

# Create IAM Role for the Project
role_response=$(aws iam create-role --role-name "$role_name" --assume-role-policy-document '{
    "Version": "2012-10-17",
    "Statement": [{
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
            "Service": [
                "lambda.amazonaws.com",
                "s3.amazonaws.com",
                "sns.amazonaws.com"
            ]
        }
    }]
}')

# Extract the role ARN from the JSON response and store it in a variable
role_arn=$(echo "$role_response" | jq -r '.Role.Arn')
echo "Role ARN: $role_arn"

# Attach permissions to the role
aws iam attach-role-policy --role-name $role_name --policy-arn arn:aws:iam::aws:policy/AWSLambda_FullAccess
aws iam attach-role-policy --role-name $role_name --policy-arn arn:aws:iam::aws:policy/AmazonSNSFullAccess

# Create the S3 bucket and store the output in a variable
bucket_output=$(aws s3api create-bucket --bucket "$bucket_name" --region "$aws_region")
echo "Bucket creation output: $bucket_output"

# Upload a file to the bucket
aws s3 cp ./example_file.txt s3://"$bucket_name"/example_file.txt

# Create a ZIP file to upload the Lambda Function
zip -r s3-lambda-function.zip ./s3-lambda-function

sleep 5
# Create a lambda function
aws lambda create-function \
    --region "$aws_region" \
    --function-name "$lambda_func_name" \
    --runtime "python3.12" \
    --handler "s3-lambda-function/s3-lambda-function.lambda_handler" \
    --memory-size 128 \
    --timeout 30 \
    --role "arn:aws:iam::$aws_account_id:role/$role_name" \
    --zip-file "fileb://./s3-lambda-function.zip"

# Add permissions to S3 bucket to invoke Lambda
aws lambda add-permission \
    --function-name "$lambda_func_name" \
    --statement-id "s3-lambda-sns" \
    --action "lambda:InvokeFunction" \
    --principal s3.amazonaws.com \
    --source-arn "arn:aws:s3:::$bucket_name"   

# Create an S3 event trigger for the Lambda function
LambdaFunctionArn="arn:aws:lambda:us-east-1:$aws_account_id:function:s3-lambda-function"
aws s3api put-bucket-notification-configuration \
  --region "$aws_region" \
  --bucket "$bucket_name" \
  --notification-configuration '{
    "LambdaFunctionConfigurations": [{
        "LambdaFunctionArn": "'"$LambdaFunctionArn"'",
        "Events": ["s3:ObjectCreated:*"]
    }]
}'    

# Create an SNS topic and save the topic ARN to a variable
topic_arn=$(aws sns create-topic --name s3-lambda-sns --output json | jq -r '.TopicArn')
echo "SNS Topic ARN: $topic_arn"

# Add SNS publish permission to the Lambda Function
aws sns subscribe \
  --topic-arn "$topic_arn" \
  --protocol email \
  --notification-endpoint "$email_address"

# Publish SNS
aws sns publish \
  --topic-arn "$topic_arn" \
  --subject "A new object created in s3 bucket" \
  --message "Hello from Teodor!"