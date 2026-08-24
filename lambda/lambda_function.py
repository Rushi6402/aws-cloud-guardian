import json


def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "project": "AWS Cloud Health Monitor",
            "status": "healthy",
            "message": "Cloud Health Monitor is running"
        })
    }
    