#!/bin/bash

# install cert-manager
# The operator uses webhooks for validating user input before persisting it in Etcd. 
# Webhooks require TLS certificates that are generated and managed by a certificate 
# manager.
echo 'Installing cert-manager...';
kubectl apply -f https://github.com/jetstack/cert-manager/releases/latest/download/cert-manager.yaml;


# wait
echo '';
echo 'Waiting for cert-manager...';
sleep 30s;

# install the operator
# Operator pod replicas are set to a default of 3 for High Availability, which can be scaled up and down.
echo '';
echo 'Installing the Oracle Database Operator...';
kubectl apply -f https://raw.githubusercontent.com/oracle/oracle-database-operator/main/oracle-database-operator.yaml;
