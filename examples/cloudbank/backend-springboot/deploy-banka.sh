#!/bin/bash
## Copyright (c) 2022 Oracle and/or its affiliates.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# building image string
if [ -z "$BACKEND_IMAGE" ]; then
  DOCKER_REGISTRY=$(jq -r .lab.docker_registry $CB_STATE_DIR/state.json)
  IMG=$(jq -r .app.backend.image.name $CB_STATE_DIR/state.json)
  VERSION=$(jq -r .app.backend.image.version $CB_STATE_DIR/state.json)
  export BACKEND_IMAGE="$DOCKER_REGISTRY/$IMG:$VERSION"
fi

# other
BANK_NAME=$(jq -r .app.services.banka $CB_STATE_DIR/state.json)
DB_WALLET_SECRET=$(jq -r .app.secrets.DB_WALLET_SECRET $CB_STATE_DIR/state.json)
DB_NAME=$(jq -r .app.backend.pdb_name $CB_STATE_DIR/state.json)

echo -n create banka deployment and service...
export CURRENTTIME=generated

# resource locations
BANKA_DEPLOYMENT=$CB_STATE_DIR/generated/banka-deployment-$CURRENTTIME.yaml
BANKA_SERVICE=$CB_STATE_DIR/generated/banka-service.yaml

# generate resource files
cp $CB_ROOT_DIR/backend-springboot/bank-deployment.yaml $BANKA_DEPLOYMENT
cp $CB_ROOT_DIR/backend-springboot/banka-service.yaml $BANKA_SERVICE

# update resource files
sed -e  "s|%BACKEND_IMAGE%|${BACKEND_IMAGE}|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
sed -e  "s|%BANK_NAME%|${BANK_NAME}|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
sed -e  "s|%db-wallet-secret%|${DB_WALLET_SECRET}|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
sed -e  "s|%PDB_NAME%|${DB_NAME}|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
sed -e  "s|%USER%|bankauser|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT

sed -e  "s|%localbankqueueschema%|aquser|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
sed -e  "s|%localbankqueuename%|BANKAQUEUE|g" $BANKA_DEPLOYMENT> /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
sed -e  "s|%banksubscribername%|banka_service|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT

sed -e  "s|%remotebankqueueschema%|aquser|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
sed -e  "s|%remotebankqueuename%|BANKBQUEUE|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT

# apply resource files
echo "DONE"
kubectl apply -f $BANKA_DEPLOYMENT
kubectl apply -f $BANKA_SERVICE
echo ""

#if [ -z "$ORDER_DB_NAME" ]; then
#    echo "ORDER_DB_NAME not set. Will get it from setup.json"
#
#fi
#
#if [ -z "$ORDER_DB_NAME" ]; then
#    echo "Error: ORDER_DB_NAME env variable needs to be set!"
#    exit 1
#fi
#export CURRENTTIME=$( date '+%F_%H:%M:%S' )