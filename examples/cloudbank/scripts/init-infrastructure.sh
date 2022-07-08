#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )

# Generate Terraform Vars file
echo -n 'Preparing terraform...'
source $CB_TERRAFORM_DIR/terraform.env
echo 'DONE'
echo ''

# Run terraform
echo -n 'Creating cloud infrastructure resources...'
cd $CB_TERRAFORM_DIR

touch $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-init.log
terraform init > $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-init.log

touch $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-apply.log
terraform apply --auto-approve > $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-apply.log

cd $LAB_HOME