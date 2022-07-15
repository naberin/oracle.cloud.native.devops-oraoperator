#!/bin/bash
# set location
location=$CB_TERRAFORM_DIR

# mark start
state_set '.state.terminate|= $VAL' STARTED

# create log-file
logfile=$CB_STATE_DIR/logs/$CURRENT_TIME-terraform-destroy.log
touch $logfile

# init
terraform -chdir="${location}" init > $logfile

# destroy
terraform -chdir="${location}" destroy --auto-approve > $logfile

# mark complete
state_set '.state.terminate|= $VAL' DONE