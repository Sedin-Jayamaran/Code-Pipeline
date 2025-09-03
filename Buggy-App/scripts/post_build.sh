#!/bin/bash
set -e  # exit if any command fails

echo "Pushing Docker image to ECR..."
docker push "$BUGGY_APP"

echo "Docker image pushed successfully."

echo "Creating imagedefinitions.json for ECS..."
printf '[{"name":"buggy-web","imageUri":"%s"}]' "$BUGGY_APP" > imagedefinitions.json

echo "Running Terraform in Buggy-App/Terraform..."
cd Buggy-App/Terraform

terraform init
terraform apply --auto-approve -var="image=$BUGGY_APP" -var-file=terraform.tfvars
