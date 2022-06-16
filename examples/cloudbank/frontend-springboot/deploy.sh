#!/bin/bash
## Copyright (c) 2022 Oracle and/or its affiliates.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

CLOUDBANK_USERNAME=$(jq -r .app.frontend.user $CB_STATE_DIR/state.json)
CLOUDBANK_SERVICE_NAMESPACE=$(jq -r .namespace $CB_STATE_DIR/state.json)
CLOUDBANK_SERVICE_BANKA=$(jq -r .app.services.banka $CB_STATE_DIR/state.json)
CLOUDBANK_SERVICE_BANKB=$(jq -r .app.services.bankb $CB_STATE_DIR/state.json)
CLOUDBANK_SERVICE_PORT=$(jq -r .app.services.port $CB_STATE_DIR/state.json)
CLOUDBANK_CREDENTIALS_SECRET_KEY=$(jq -r .app.secrets.FRONTEND_CREDENTIALS.key $CB_STATE_DIR/state.json)
CLOUDBANK_CREDENTIALS_SECRET_NAME=$(jq -r .app.secrets.FRONTEND_CREDENTIALS.name $CB_STATE_DIR/state.json)

# Build APIs
CLOUDBANK_APIS_BANKA=http://${CLOUDBANK_SERVICE_BANKA}.${CLOUDBANK_SERVICE_NAMESPACE}:${CLOUDBANK_SERVICE_PORT}
CLOUDBANK_APIS_BANKB=http://${CLOUDBANK_SERVICE_BANKB}.${CLOUDBANK_SERVICE_NAMESPACE}:${CLOUDBANK_SERVICE_PORT}
export CURRENTTIME=generated

# Retrieve image
if [ -z "$FRONTEND_IMAGE" ]; then
  echo "FRONTEND_IMAGE not set. Will get it from setup.json"
  DOCKER_REGISTRY=$(jq -r .lab.docker_registry $CB_STATE_DIR/state.json)
  FRONTEND_IMAGE_VALUE=$(jq -r .app.frontend.image.name $CB_STATE_DIR/state.json)
  FRONTEND_IMAGE_VERSION=$(jq -r .app.frontend.image.version $CB_STATE_DIR/state.json)
  export FRONTEND_IMAGE="${DOCKER_REGISTRY}/${FRONTEND_IMAGE_VALUE}:${FRONTEND_IMAGE_VERSION}"
fi

echo "creating frontend deployment and service..."
# resource locations and copying from template
FRONTEND_MANIFEST=$CB_STATE_DIR/generated/frontend-manifest.yaml
cp $CB_ROOT_DIR/frontend-springboot/manifest.yaml $FRONTEND_MANIFEST

# Replacing Container Image
sed -e  "s|%CLOUDBANK_APP_IMAGE%|$FRONTEND_IMAGE|g" $FRONTEND_MANIFEST > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml $FRONTEND_MANIFEST

# Replacing Auth Credentials

sed -e  "s|%CLOUDBANK_SECURITY_PWD_SECRET_NAME%|$CLOUDBANK_CREDENTIALS_SECRET_NAME|g" $FRONTEND_MANIFEST > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml $FRONTEND_MANIFEST

sed -e  "s|%CLOUDBANK_SECURITY_PWD_SECRET_KEY%|$CLOUDBANK_CREDENTIALS_SECRET_KEY|g" $FRONTEND_MANIFEST > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml $FRONTEND_MANIFEST

sed -e  "s|%CLOUDBANK_SECURITY_USERNAME%|$CLOUDBANK_USERNAME|g" $FRONTEND_MANIFEST > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml $FRONTEND_MANIFEST


# Replacing API Endpoints
sed -e  "s|%CLOUDBANK_APIS_BANKA%|$CLOUDBANK_APIS_BANKA|g" $FRONTEND_MANIFEST > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml $FRONTEND_MANIFEST

sed -e  "s|%CLOUDBANK_APIS_BANKB%|$CLOUDBANK_APIS_BANKB|g" $FRONTEND_MANIFEST > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml $FRONTEND_MANIFEST


# Apply Manifest
kubectl apply -f $FRONTEND_MANIFEST

