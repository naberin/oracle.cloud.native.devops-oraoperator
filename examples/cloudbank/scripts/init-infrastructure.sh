#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )

# Generate Terraform Vars file
$CB_STATE_DIR/tasks/terraform-env.sh

# Run terraform
$CB_STATE_DIR/tasks/terraform-create.sh &