#!/bin/bash
## Copyright (c) 2022 Oracle and/or its affiliates.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

CLOUDBANK_USERNAME=$(jq -r .FRONTEND.USER ../setup.json)
CLOUDBANK_SERVICE_NAMESPACE=$(jq -r .CLOUDBANK.NAMESPACE ../setup.json)
CLOUDBANK_SERVICE_BANKA=$(jq -r .CLOUDBANK.SERVICES.BANKA ../setup.json)
CLOUDBANK_SERVICE_BANKB=$(jq -r .CLOUDBANK.SERVICES.BANKB ../setup.json)
CLOUDBANK_SERVICE_PORT=$(jq -r .CLOUDBANK.SERVICES.PORT ../setup.json)
CLOUDBANK_CREDENTIALS_SECRET_KEY=$(jq -r .SECRETS.FRONTEND_CREDENTIALS.key ../setup.json)
CLOUDBANK_CREDENTIALS_SECRET_NAME=$(jq -r .SECRETS.FRONTEND_CREDENTIALS.name ../setup.json)

# Build APIs
CLOUDBANK_APIS_BANKA=http://${CLOUDBANK_SERVICE_BANKA}.${CLOUDBANK_SERVICE_NAMESPACE}:${CLOUDBANK_SERVICE_PORT}
CLOUDBANK_APIS_BANKB=http://${CLOUDBANK_SERVICE_BANKB}.${CLOUDBANK_SERVICE_NAMESPACE}:${CLOUDBANK_SERVICE_PORT}
export CURRENTTIME=generated

# Retrieve image
if [ -z "$FRONTEND_IMAGE" ]; then
  echo "FRONTEND_IMAGE not set. Will get it from setup.json"
  DOCKER_REGISTRY=$(jq -r .DOCKER_REGISTRY.value ../setup.json)
  FRONTEND_IMAGE_VALUE=$(jq -r .FRONTEND.IMAGE.value ../setup.json)
  FRONTEND_IMAGE_VERSION=$(jq -r .FRONTEND.IMAGE.version ../setup.json)
  export FRONTEND_IMAGE="${DOCKER_REGISTRY}/${FRONTEND_IMAGE_VALUE}:${FRONTEND_IMAGE_VERSION}"
fi

echo "creating frontend deployment and service..."
cp manifest.yaml manifest-$CURRENTTIME.yaml

# Replacing Container Image
sed -e  "s|%CLOUDBANK_APP_IMAGE%|$FRONTEND_IMAGE|g" manifest-$CURRENTTIME.yaml > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml manifest-$CURRENTTIME.yaml

# Replacing Auth Credentials

sed -e  "s|%CLOUDBANK_SECURITY_PWD_SECRET_NAME%|$CLOUDBANK_CREDENTIALS_SECRET_NAME|g" manifest-$CURRENTTIME.yaml > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml manifest-$CURRENTTIME.yaml

sed -e  "s|%CLOUDBANK_SECURITY_PWD_SECRET_KEY%|$CLOUDBANK_CREDENTIALS_SECRET_KEY|g" manifest-$CURRENTTIME.yaml > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml manifest-$CURRENTTIME.yaml

sed -e  "s|%CLOUDBANK_SECURITY_USERNAME%|$CLOUDBANK_USERNAME|g" manifest-$CURRENTTIME.yaml > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml manifest-$CURRENTTIME.yaml


# Replacing API Endpoints
sed -e  "s|%CLOUDBANK_APIS_BANKA%|$CLOUDBANK_APIS_BANKA|g" manifest-$CURRENTTIME.yaml > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml manifest-$CURRENTTIME.yaml

sed -e  "s|%CLOUDBANK_APIS_BANKB%|$CLOUDBANK_APIS_BANKB|g" manifest-$CURRENTTIME.yaml > /tmp/manifest-$CURRENTTIME.yaml
mv -- /tmp/manifest-$CURRENTTIME.yaml manifest-$CURRENTTIME.yaml


# Apply Manifest
kubectl apply -f manifest-$CURRENTTIME.yaml

