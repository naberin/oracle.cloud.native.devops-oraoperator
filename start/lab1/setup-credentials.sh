#!/bin/bash

# #########
# Variables
# #########
TENANCY_OCID=$ENV_TENANCY_OCID
USER_OCID=$ENV_USER_OCID
FINGERPRINT=$ENV_FINGERPRINT
REGION=$ENV_REGION
PATH_TO_PRIVATE_KEY=$ENV_PATH_TO_PRIVATE_KEY
OCI_CONFIG='oci-config'
OCI_PRIVKEY_SEC='oci-privatekey'
OCI_DB_SEC='admin-password'
OCI_DB_PWD_LOC=$ENV_PATH_TO_DB_PWD

# ##################################
# Create Config Map using OCI Config
# Create Secret using PrivateKey loc
# Create Secret for Database pwd
# ##################################
kubectl create configmap $OCI_CONFIG \
--from-literal=tenancy=$TENANCY_OCID \
--from-literal=user=$USER_OCID \
--from-literal=fingerprint=$FINGERPRINT \
--from-literal=region=$REGION


kubectl create secret generic $OCI_PRIVKEY_SEC \
--from-file=privatekey=$PATH_TO_PRIVATE_KEY


kubectl create secret generic $OCI_DB_SEC \
--from-file=admin-password=$OCI_DB_PWD_LOC