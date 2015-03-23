#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DATA_DIR=${DIR}/_data
CSV_FILE=${DIR}/_data/all.csv # hardcoded in cloudtrail.sql...
DB_FILE=${DIR}/_data/all.db

# Customize these
S3_BUCKET="some-bucket"
S3_ACCOUNT="1234567890"
AWS_REGION="us-east-1"

# or customize the full paths:
S3_DT_PATH="s3://${S3_BUCKET}/AWSLogs/${S3_ACCOUNT}/CloudTrail/${AWS_REGION}/%Y/%m/%d/"
S3_DT_INCLUDE="${S3_ACCOUNT}_CloudTrail_${AWS_REGION}_%Y%m%dT%H*"
