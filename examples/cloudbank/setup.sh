#!/bin/bash

echo -n 'Beginning Lab setup...'
# Make directory for lab-related files
if [ -d $CB_STATE_DIR ]; then
  CURRENT_TIME=$( date '+%F_%H:%M:%S' )
  echo ''
  echo 'Pre-existing state directory found. Renaming old-lab directory...'
  mv $CB_STATE_DIR $CB_STATE_DIR-$CURRENT_TIME
  mkdir -p $CB_STATE_DIR;
fi
echo 'DONE'


# Copy JSON as new state
echo -n 'Generating State file...'
cp $CB_ROOT_DIR/setup.json $CB_STATE_DIR/state.json
chmod 700 $CB_STATE_DIR/state.json
echo 'DONE'

# Copy Terraform into state directory
echo -n 'Copy Lab Terraform files...'
cp -r $CB_ROOT_DIR/terraform $CB_TERRAFORM_DIR
echo 'DONE'


# Copy Kubernetes scripts
echo -n 'Copying Lab related scripts...'
echo 'DONE'


# Run terraform
echo -n 'Creating cloud infrastructure resources...'
echo 'DONE'