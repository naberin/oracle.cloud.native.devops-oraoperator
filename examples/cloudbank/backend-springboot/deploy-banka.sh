#!/bin/bash
## Copyright (c) 2022 Oracle and/or its affiliates.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# building image string
if [ -z "$BACKEND_IMAGE" ]; then
  DOCKER_REGISTRY=$(state_get .lab.docker_registry)
  IMG=$(state_get .app.backend.image.name)
  VERSION=$(state_get .app.backend.image.version)
  export BACKEND_IMAGE="$DOCKER_REGISTRY/$IMG:$VERSION"
fi

# other
BANK_NAME=$(state_get .app.services.banka)
DB_WALLET_SECRET=$(state_get .app.secrets.DB_WALLET_SECRET)
DB_NAME=$(state_get .app.backend.pdb_name)

echo -n create banka deployment and service...
export CURRENTTIME=generated

# determine database type
# and how to connect
DBKIND=$(state_get .lab.database.selected)

# resource locations
BANKA_DEPLOYMENT=$CB_STATE_DIR/generated/banka-deployment-$CURRENTTIME.yaml
BANKA_SERVICE=$CB_STATE_DIR/generated/banka-service.yaml

# generate resource files
if [[ $DBKIND == SIDB ]]; then
  cp $CB_ROOT_DIR/backend-springboot/bank-deployment-sidb.yaml $BANKA_DEPLOYMENT
elif [[ $DBKIND == ADB ]]; then
  cp $CB_ROOT_DIR/backend-springboot/bank-deployment.yaml $BANKA_DEPLOYMENT
fi

cp $CB_ROOT_DIR/backend-springboot/banka-service.yaml $BANKA_SERVICE

# update resource files
sed -e  "s|%BACKEND_IMAGE%|${BACKEND_IMAGE}|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
sed -e  "s|%BANK_NAME%|${BANK_NAME}|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT

if [[ $DBKIND == SIDB ]]; then
  CONNECTIONSTRING=$(kubectl get singleinstancedatabase cloudbankdb -o "jsonpath={.status.pdbConnectString}")
  sed -e  "s|%CONNECTIONSTRING%|${CONNECTIONSTRING}|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
  mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
elif [[ $DBKIND == ADB ]]; then
  sed -e  "s|%db-wallet-secret%|${DB_WALLET_SECRET}|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
  mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
  sed -e  "s|%PDB_NAME%|${DB_NAME}|g" $BANKA_DEPLOYMENT > /tmp/bank-deployment-$CURRENTTIME.yaml
  mv -- /tmp/bank-deployment-$CURRENTTIME.yaml $BANKA_DEPLOYMENT
fi

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