#!/bin/bash
# set location
location=$CB_TERRAFORM_DIR

# mark start
state_set '.state.provision|= $VAL' STARTED

# create log-file
logfile=$CB_STATE_DIR/logs/$CURRENT_TIME-terraform-apply.log
touch $logfile

# init
terraform -chdir="${location}" init > $logfile

# apply
terraform -chdir="${location}" apply --auto-approve > $logfile

# mark complete
state_set '.state.provision|= $VAL' DONE
