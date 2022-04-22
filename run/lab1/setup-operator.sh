#!/bin/bash

# install cert-manager
# The operator uses webhooks for validating user input before persisting it in Etcd. 
# Webhooks require TLS certificates that are generated and managed by a certificate 
# manager.
kubectl apply -f https://github.com/jetstack/cert-manager/releases/latest/download/cert-manager.yaml


# wait
# todo: observe the right length of time for waiting
sleep 10s

# install the operator
# Operator pod replicas are set to a default of 3 for High Availability, which can be scaled up and down.
kubectl apply -f https://raw.githubusercontent.com/oracle/oracle-database-operator/main/oracle-database-operator.yaml
