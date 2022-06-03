#!/bin/bash
## Copyright (c) 2022 Oracle and/or its affiliates.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

SCRIPT_DIR=$(dirname $0)
DB_WALLET_SECRET=$(jq .SECRETS.DB_WALLET_SECRET.name ../setup.json)

if [ -z "$DOCKER_REGISTRY" ]; then
    echo "DOCKER_REGISTRY not set. Will get it from setup.json"
    export $DOCKER_REGISTRY=$(jq .DOCKER_REGISTRY.value ../setup.json)
fi

if [ -z "$DOCKER_REGISTRY" ]; then
    echo "Error: DOCKER_REGISTRY env variable needs to be set!"
    exit 1
fi

if [ -z "$ORDER_DB_NAME" ]; then
    echo "ORDER_DB_NAME not set. Will get it from setup.json"
  export ORDER_DB_NAME=$(jq .CLOUDBANK.DATABASE.name ../setup.json)
fi

if [ -z "$ORDER_DB_NAME" ]; then
    echo "Error: ORDER_DB_NAME env variable needs to be set!"
    exit 1
fi

echo create banka deployment and service...
export CURRENTTIME=generated
#export CURRENTTIME=$( date '+%F_%H:%M:%S' )
echo CURRENTTIME is $CURRENTTIME  ...this will be appended to generated deployment yaml

cp bank-deployment.yaml bank-deployment-$CURRENTTIME.yaml

sed -e  "s|%DOCKER_REGISTRY%|${DOCKER_REGISTRY}|g" bank-deployment-$CURRENTTIME.yaml > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml bank-deployment-$CURRENTTIME.yaml
sed -e  "s|%BANK_NAME%|banka|g" bank-deployment-${CURRENTTIME}.yaml > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml bank-deployment-$CURRENTTIME.yaml
sed -e  "s|%db-wallet-secret%|${DB_WALLET_SECRET}|g" bank-deployment-${CURRENTTIME}.yaml > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml bank-deployment-$CURRENTTIME.yaml
sed -e  "s|%PDB_NAME%|${ORDER_DB_NAME}|g" bank-deployment-${CURRENTTIME}.yaml > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml bank-deployment-$CURRENTTIME.yaml
sed -e  "s|%USER%|bankauser|g" bank-deployment-${CURRENTTIME}.yaml > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml bank-deployment-$CURRENTTIME.yaml

sed -e  "s|%localbankqueueschema%|aquser|g" bank-deployment-${CURRENTTIME}.yaml > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml bank-deployment-$CURRENTTIME.yaml
sed -e  "s|%localbankqueuename%|BANKAQUEUE|g" bank-deployment-${CURRENTTIME}.yaml > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml bank-deployment-$CURRENTTIME.yaml
sed -e  "s|%banksubscribername%|banka_service|g" bank-deployment-${CURRENTTIME}.yaml > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml bank-deployment-$CURRENTTIME.yaml

sed -e  "s|%remotebankqueueschema%|aquser|g" bank-deployment-${CURRENTTIME}.yaml > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml bank-deployment-$CURRENTTIME.yaml
sed -e  "s|%remotebankqueuename%|BANKBQUEUE|g" bank-deployment-${CURRENTTIME}.yaml > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml bank-deployment-$CURRENTTIME.yaml

kubectl apply -f $SCRIPT_DIR/bank-deployment-$CURRENTTIME.yaml

kubectl apply -f $SCRIPT_DIR/banka-service.yaml
