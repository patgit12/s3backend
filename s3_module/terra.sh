#!/bin/bash
# this script is made locally to test if your terraform code is compliant. we used tfsec(installed with pip) and checkov(installed with chocalatey)
set -x
export TF_LOG="DEBUG"
export TF_LOG_PATH=./terra.log
ENV=prod
TF_PLAN=${ENV}.tfplan

[ -d .terraform ] && rm -rf .terraform
rm -rf *.tfplan
sleep 2

terraform fmt -recursive
terraform init
terraform validate
#tfsec . # tfsec has already been installed using choco
terraform plan -out=${TF_PLAN}
terraform show -json ${TF_PLAN} > ${TF_PLAN}.json
checkov -f ${TF_PLAN}.json --skip-check LOW
if [ "$?" -eq "0" ]
then
  echo "Your configuration is valid"
else
  echo "Your code needs some work"
  exit 1

fi
terraform plan -out=${TF_PLAN}

if [ -f "${TF_PLAN}" ]
then
  echo " **** The Plan does not exist****"
  exit 1
