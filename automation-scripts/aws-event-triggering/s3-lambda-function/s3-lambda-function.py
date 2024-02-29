import boto3
import json
import logging

sns_client = boto3.client("sns")
topic_arn = "arn:aws:sns:us-east-1:<your-account-id>:s3-lambda-sns"


def lambda_handler(event, context):
    try:
        # Extract relevant information from the S3 event trigger
        s3_record = event["Records"][0]["s3"]
        bucket_name = s3_record["bucket"]["name"]
        object_key = s3_record["object"]["key"]

        # Perform desired operations with the uploaded file
        logging.info(f"File '{object_key}' was uploaded to bucket '{bucket_name}'")

        # Send a notification via SNS
        sns_client.publish(
            TopicArn=topic_arn,
            Subject="S3 Object Created",
            Message=f"File '{object_key}' was uploaded to bucket '{bucket_name}'",
        )

        return {
            "statusCode": 200,
            "body": json.dumps("Lambda function executed successfully"),
        }

    except Exception as e:
        # Log any exceptions
        logging.error(f"An error occurred: {e}")
        return {
            "statusCode": 500,
            "body": json.dumps("An error occurred while processing the request"),
        }
