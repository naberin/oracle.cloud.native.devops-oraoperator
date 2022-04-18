#!/bin/bash

# #########
# Variables
# #########
ADBNAME=$1
OCICOMPARTMENTOCID=$2
OCIVAULTOCID=$3
ADBRESOURCENAME='CLOUDBANKDB'

# ##########################################
# Provision
# provisions the database using the Operator
# ##########################################

if [ ! -z "$ADBNAME" ];
then
    tmplt=`cat "../templates/adb-provision.yml.template" | sed -e "s/{{ADBRESOURCENAME}}/$ADBRESOURCENAME/g" -e "s/{{ADBNAME}}/$ADBNAME/g" -e "s/{{OCICOMPARTMENTOCID}}/$OCICOMPARTMENTOCID/g" -e "s/{{OCIVAULTOCID}}/$OCIVAULTOCID/g"`
    echo "$tmplt" | kubectl apply -f -;
fi