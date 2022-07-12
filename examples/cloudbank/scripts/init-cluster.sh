#!/bin/bash
# Sets the following cluster-related objects and settings
# - namespace

# mark start
state_set '.state.clustersetup|= $VAL' STARTED

# Apply Namespace
NS=$(state_get .namespace)
kubectl apply -f $CB_KUBERNETES_TEMPLATES_DIR/namespace.yaml
kubectl config set-context --current --namespace=$NS
kubectl config view --minify | grep namespace:

# Apply service account
kubectl apply -f $CB_KUBERNETES_TEMPLATES_DIR/service-account.yaml

state_set '.state.clustersetup|= $VAL' DONE