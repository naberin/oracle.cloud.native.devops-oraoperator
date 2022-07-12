# set location
location=$CB_TERRAFORM_DIR

# create log-file
logfile=$CB_STATE_DIR/logs/$CURRENT_TIME-terraform-destroy.log
touch $logfile

# init
terraform -chdir="${location}" init > $logfile

# destroy
terraform -chdir="${location}" destroy --auto-approve > $logfile
