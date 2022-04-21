#!/bin/bash

# #########
# Variables
# #########
DBOCID=$1
DBWALLETSECRETNAME=$2
DBWALLETACTUALPASS=$3
DBWALLETPASSWORD=$4
DBWALLETINSTANCENAME='instance-wallet'

# ###############################################
# Generate Wallet
# Generate the database wallet using the Operator
# ###############################################
kubectl create secret generic $DBWALLETSECRETNAME --from-literal=$DBWALLETSECRETNAME=$DBWALLETPASS

if [ ! -z "$DBWALLETSECRETNAME" ];
then
    tmplt=`cat "../templates/adb-wallet.yml" | sed -e "s/{{DBWALLETSECRETNAME}}/$DBWALLETSECRETNAME/g" -e "s/{{DBNAME}}/$DBNAME/g" -e "s/{{DBWALLETINSTANCENAME}}/$DBWALLETINSTANCENAME/g" -e "s/{{DBOCID}}/$DBOCID/g"`
    echo "$tmplt" | kubectl apply -f -;
fi
