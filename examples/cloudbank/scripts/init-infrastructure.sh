#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )

# Generate Terraform Vars file
./tasks/terraform-env.sh

# Run terraform
./tasks/terraform-create.sh &