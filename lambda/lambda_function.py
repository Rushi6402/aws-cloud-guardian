import json
import boto3
import logging
from datetime import datetime, timezone

logger = logging.getLogger()
logger.setLevel(logging.INFO)

REGION = "us-east-1"

ec2 = boto3.client("ec2", region_name=REGION)
rds = boto3.client("rds", region_name=REGION)
lambda_client = boto3.client("lambda", region_name=REGION)


def check_ec2():
    try:
        response = ec2.describe_instances()

        running = 0
        stopped = 0

        for reservation in response["Reservations"]:
            for instance in reservation["Instances"]:
                state = instance["State"]["Name"]

                if state == "running":
                    running += 1
                elif state == "stopped":
                    stopped += 1

        return {
            "status": "healthy",
            "running": running,
            "stopped": stopped
        }

    except Exception as e:
        logger.exception("EC2 health check failed")

        return {
            "status": "unhealthy",
            "error": str(e)
        }


def check_rds():
    try:
        response = rds.describe_db_instances()

        available = 0
        unavailable = 0

        for instance in response["DBInstances"]:
            status = instance["DBInstanceStatus"]

            if status == "available":
                available += 1
            else:
                unavailable += 1

        return {
            "status": "healthy" if unavailable == 0 else "warning",
            "available": available,
            "unavailable": unavailable
        }

    except Exception as e:
        logger.exception("RDS health check failed")

        return {
            "status": "unhealthy",
            "error": str(e)
        }


def check_lambda():
    try:
        response = lambda_client.list_functions()

        total = len(response["Functions"])

        active = 0

        for function in response["Functions"]:
            state = function.get("State", "Active")

            if state == "Active":
                active += 1

        return {
            "status": "healthy",
            "total_functions": total,
            "active_functions": active
        }

    except Exception as e:
        logger.exception("Lambda health check failed")

        return {
            "status": "unhealthy",
            "error": str(e)
        }


def lambda_handler(event, context):

    logger.info("Starting AWS Cloud Guardian health check")

    ec2_health = check_ec2()
    rds_health = check_rds()
    lambda_health = check_lambda()

    checks = {
        "ec2": ec2_health,
        "rds": rds_health,
        "lambda": lambda_health
    }

    unhealthy = any(
        check["status"] == "unhealthy"
        for check in checks.values()
    )

    warning = any(
        check["status"] == "warning"
        for check in checks.values()
    )

    if unhealthy:
        overall_status = "unhealthy"
    elif warning:
        overall_status = "warning"
    else:
        overall_status = "healthy"

    result = {
        "project": "AWS Cloud Health Monitor",
        "status": overall_status,
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "region": REGION,
        "checks": checks
    }

    logger.info("Cloud Guardian health check completed")
    logger.info(json.dumps(result))

    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(result)
    }