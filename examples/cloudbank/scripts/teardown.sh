
# terminate Database and Loadbalancer
kubectl delete AutonomousDatabase/cloudbankdb
kubectl delete service/cloudbank-service


# teardown infrastructure resources
cd $CB_TERRAFORM_DIR
touch $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-destroy.log
terraform destroy -y 2>&1 | tee $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-destroy.log
cd $LAB_HOME