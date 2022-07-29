#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )

# terminate Database and Loadbalancer
touch $CB_STATE_DIR/logs/$CURRENT_TIME-kubectl-version.log


# if kubernetes cluster exists
if kubectl version >> $CB_STATE_DIR/logs/$CURRENT_TIME-kubectl-version.log; then

  # determine database to delete
  DBKIND=$(state_get .lab.database.selected)

  if [[ $DBKIND == SIDB ]]; then
    kubectl delete SingleInstanceDatabase/cloudbankdb
  elif [[ $DBKIND == ADB ]]; then
    ./gen-adb-delete.sh
    kubectl apply -f $CB_STATE_DIR/generated/adb-delete.yaml
    kubectl delete AutonomousDatabase/cloudbankdb
  fi

  FESERVICE=$(kubectl get svc/frontend-service -o name | grep service/frontend-service)
  if [ -n $FESERVICE ]; then
    kubectl delete service/frontend-service
  fi

fi

# teardown infrastructure resources


# Generate Terraform Vars file
echo -n 'Preparing terraform...'
envfile=$CB_TERRAFORM_DIR/terraform.env
. $envfile
echo 'DONE'

# Run terraform
$CB_STATE_DIR/tasks/terraform-destroy.sh &


# return
cd $LAB_HOME