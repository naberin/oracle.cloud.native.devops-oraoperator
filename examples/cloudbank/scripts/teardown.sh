#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )

# terminate Database and Loadbalancer
touch $CB_STATE_DIR/logs/$CURRENT_TIME-kubectl-version.log

# if kubernetes cluster exists
if kubectl version >> $CB_STATE_DIR/logs/$CURRENT_TIME-kubectl-version.log; then
  # todo: check if services and loadblaancer are properly deleted
  ./gen-adb-delete.sh
  
  kubectl delete service/frontend-service
fi

# teardown infrastructure resources
cd $CB_TERRAFORM_DIR

# set terraform vars
source terraform.env

# init
if ! terraform init; then
    echo 'ERROR: terraform init failed!'
    exit 1
fi

# destroy
touch $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-destroy.log
if ! terraform destroy --auto-approve 2>&1 | tee $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-destroy.log; then
    echo 'ERROR: terraform destroy failed!'
    exit 1
fi

# return
cd $LAB_HOME