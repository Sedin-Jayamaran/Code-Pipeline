#!/bin/bash
set -e  # exit on first error

echo "Installing Terraform..."
yum install -y yum-utils

echo "Adding HashiCorp repo..."
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

echo "Installing Terraform package..."
yum -y install terraform

echo "Logging into Amazon ECR..."
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $ECR_URI

echo "Setting commit ID and BUGGY_APP..."
export COMMIT_ID=$(echo $CODEBUILD_RESOLVED_SOURCE_VERSION | cut -c 1-10)
export BUGGY_APP="${ECR_URI}:${COMMIT_ID}"

echo "Environment variable BUGGY_APP set to: $BUGGY_APP"
