#!/usr/bin/env bash

set -xue

AWS_ACCOUNT=$(aws sts get-caller-identity | jq -r .Account)

if [[ "$AWS_ACCOUNT" != 445285296882 ]]; then
    echo "Invalid AWS Account: $AWS_ACCOUNT" >&2
    exit 2
fi

ROOT=$(cd "$(dirname "$0")" && pwd)

sam deploy \
    --region "us-east-1" \
    --stack-name "mecab-ecr" \
    --capabilities CAPABILITY_IAM \
    --template-file "${ROOT}/ecr.yml"
