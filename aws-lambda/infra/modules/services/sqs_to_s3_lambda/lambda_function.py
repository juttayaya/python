import os
import json
import logging
import boto3
# from aws_xray_sdk.core import xray_recorder
# from aws_xray_sdk.core import patch
# patch(['boto3'])

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def upload_s3(object_name, content):
    s3_bucket_upload = os.environ["s3_bucket_output"]
    logger.info(f"Uploading {content} to s3://{s3_bucket_upload}/{object_name}")
    encoded_str = content.encode("utf-8")
    s3 = boto3.resource("s3")
    s3.Bucket(s3_bucket_upload).put_object(Key=object_name, Body=encoded_str)


def lambda_handler(event, context):
    logger.info("START sqs_to_s3_lambda")
    logger.info("Received event: " + json.dumps(event, indent=2))
    for record in event['Records']:
        message_id = record["messageId"]
        message = record["body"]
        if message is None:
            raise Exception("No SQS message")
        else:
            logger.info(f"From SQS: {message}")
            upload_s3(message_id, message)

    logger.info("FINISH sqs_to_s3_lambda")

    return {
        'statusCode': 200
    }
