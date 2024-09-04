#!/bin/bash
echo "Running Terraform Init"
terraform init

echo "Running terraform Plan"
terraform plan


echo "Running terraform validate"
terraform validate

echo "Running Terraform Apply"
terraform apply -auto-approve

