#!/bin/bash

# #########
# Variables
# #########
DB_NAME=$1
DB_RESOURCE_NAME=$DB_NAME
OCI_COMPARTMENT_OCID=$2
DB_DISPLAY_NAME=$DB_RESOURCE_NAME
DB_PSWD_SEC='admin-password'
OCI_CONFIG='oci-config'
OCI_PRIVKEY_SEC='oci-privatekey'

# ##########################################
# Provision
# provisions the database using the Operator
# ##########################################
if [ ! -z "$DB_NAME" ];
then
    tmplt=`cat "../templates/adb-provision.yml" | sed -e "s/{{DB_NAME}}/$DB_NAME/g" -e "s/{{OCI_COMPARTMENT_OCID}}/$OCI_COMPARTMENT_OCID/g" -e "s/{{DB_RESOURCE_NAME}}/$DB_RESOURCE_NAME/g" -e "s/{{DB_DISPLAY_NAME}}/$DB_DISPLAY_NAME/g" -e "s/{{DB_PSWD_SEC}}/$DB_PSWD_SEC/g -e "s/{{OCI_CONFIG}}/$OCI_CONFIG/g" -e "s/{{OCI_PRIVKEY_SEC}}/$OCI_PRIVKEY_SEC/g" "`
    echo "$tmplt" | kubectl apply -f -;
fi
