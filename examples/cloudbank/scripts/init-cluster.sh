#!/bin/bash
# Sets the following cluster-related objects and settings
# - namespace
# - secret for fixed database objects

# todo: make sure state_get exists
# todo: handle if kubernetes cluster not setup


# Apply Namespace
NS=$(state_get .namespace)
kubectl apply -f $CB_KUBERNETES_TEMPLATES_DIR/namespace.yaml
kubectl config set-context --current --namespace=$NS
kubectl config view --minify | grep namespace:


# Create Secret
PWD=$(state_get .lab.fixed_demo_user_credential)
if [ -z $PWD ]; then
  echo "Error: Database user credentials were not found and the required secret could not be set."
  exit 1;
fi
kubectl create secret generic admin-password --from-literal=admin-password="$(state_get .lab.fixed_demo_user_credential)"
