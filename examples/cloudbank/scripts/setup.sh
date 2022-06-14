#!/bin/bash
CURRENT_TIME=$( date '+%F_%H:%M:%S' )


# Check if any of the necessary env variables exist
if [ -z $CB_STATE_DIR ] | [ -z $CB_KUBERNETES_TEMPLATES_DIR ] | [ -z $CB_ROOT_DIR ]; then
  echo 'Error: Lab variables not set. Please source source.env first';
  exit 1;
fi


# Make directories for lab-related files
echo -n 'Beginning Lab setup...'

mkdir -p $CB_STATE_DIR;
mkdir -p $CB_STATE_DIR/generated;
mkdir -p $CB_STATE_DIR/logs;
chmod 700 $CB_STATE_DIR/generated;
chmod 700 $CB_STATE_DIR/logs;

echo 'DONE'


# Copy JSON as new state
echo -n 'Generating State file...'
cp $CB_ROOT_DIR/state.json $CB_STATE_DIR/state.json
chmod 700 $CB_STATE_DIR/state.json
echo 'DONE'


# Copy Kubernetes scripts
echo -n 'Copying Lab related scripts...'
cp -r $CB_ROOT_DIR/scripts/* $CB_STATE_DIR
echo 'DONE'


# Copy Terraform into state directory
echo -n 'Copying Lab terraform files...'
cp -r $CB_ROOT_DIR/terraform $CB_TERRAFORM_DIR
echo 'DONE'


# Prompt user for input on setup
echo 'The lab requires more information...'
$CB_STATE_DIR/init-state.sh
echo 'DONE'


# Generate Terraform Vars file
echo 'Preparing terraform...'
$CB_TERRAFORM_DIR/terraform-env.sh
echo 'DONE'


# Run terraform
echo -n 'Creating cloud infrastructure resources...'
cd $CB_TERRAFORM_DIR
touch $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-init.log
terraform init 2>&1 | tee -a $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-init.log
touch $CB_STATE_DIR/logs$$CURRENT_TIME-terraform-apply.log
terraform apply --auto-approve >> $CB_STATE_DIR/logs/$CURRENT_TIME-terraform-apply.log
cd $LAB_HOME
echo 'DONE'