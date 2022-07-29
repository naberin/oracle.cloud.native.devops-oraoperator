#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )

# Generate Terraform Vars file
echo -n 'Preparing terraform...'
envfile=$CB_TERRAFORM_DIR/terraform.env
. $envfile
echo 'DONE'

# Run terraform
$CB_STATE_DIR/tasks/terraform-create.sh &