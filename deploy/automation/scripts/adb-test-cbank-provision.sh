#!/bin/bash

# #########
# Variables
# #########
DBNAME=$1
OCICOMPARTMENTOCID=$2
OCIVAULTOCID=$3
ADBRESOURCENAME='CLOUDBANKDB'

# ##########################################
# ProvisionWallet_cloudbankDB.zip
# provisions the database using the Operator
# ##########################################

if [ ! -z "$DBNAME" ];
then
    tmplt=`cat "../templates/adb-provision.yml.template" | sed -e "s/{{ADBRESOURCENAME}}/$ADBRESOURCENAME/g" -e "s/{{ADBNAME}}/$DBNAME/g" -e "s/{{OCICOMPARTMENTOCID}}/$OCICOMPARTMENTOCID/g" -e "s/{{OCIVAULTOCID}}/$OCIVAULTOCID/g"`
    echo "$tmplt" | kubectl apply -f -;
fi