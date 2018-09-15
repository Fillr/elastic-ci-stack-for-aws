#!/usr/bin/env bash

set -euo pipefail

USAGE="./fillr-bk.sh [create|update] [large|small]"

if [[ "$*" == "" ]]; then
  echo $USAGE
  exit -1
fi

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo $USAGE
  exit 0
fi

set -x

ACTION=$1
SIZE=$2

aws cloudformation "$ACTION"-stack \
  --output json \
  --stack-name buildkite-"$SIZE"-agents \
  --template-url "https://s3.amazonaws.com/buildkite-aws-stack/latest/aws-stack.yml" \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
  --parameters file://"$SIZE"-config.json
