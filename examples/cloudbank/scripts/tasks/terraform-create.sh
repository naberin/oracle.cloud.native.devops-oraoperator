# set location
location=$CB_TERRAFORM_DIR

# create log-file
logfile=$CB_STATE_DIR/logs/$CURRENT_TIME-terraform-apply.log
touch $logfile

# init
terraform -chdir="${location}" init > $logfile

# apply
terraform -chdir="${location}" apply --auto-approve > $logfile
