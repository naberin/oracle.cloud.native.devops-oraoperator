
# terminate Database and Loadbalancer
kubectl delete AutonomousDatabase/cloudbankdb
kubectl delete service/cloudbank-service


# teardown infrastructure resources
cd $CB_TERRAFORM_DIR

if ! terraform init; then
    echo 'ERROR: terraform init failed!'
    exit 1
fi
touch $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-destroy.log
if ! terraform destroy --auto-approve 2>&1 | tee $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-destroy.log; then
    echo 'ERROR: terraform destroy failed!'
    exit 1
fi

cd $LAB_HOME