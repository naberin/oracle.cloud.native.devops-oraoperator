#!/bin/bash
## Copyright (c) 2021 Oracle and/or its affiliates.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# Retrieve image
if [ -z "$FRONTEND_IMAGE" ]; then
  echo "FRONTEND_IMAGE not set. Will get it from setup.json"
  DOCKER_REGISTRY=$(jq -r .DOCKER_REGISTRY.value ../state.json)
  FRONTEND_IMAGE_VALUE=$(jq -r .FRONTEND.IMAGE.value ../state.json)
  FRONTEND_IMAGE_VERSION=$(jq -r .FRONTEND.IMAGE.version ../state.json)
  export FRONTEND_IMAGE="$DOCKER_REGISTRY/$FRONTEND_IMAGE_VALUE:$FRONTEND_IMAGE_VERSION"
fi

# Build Application
mvn clean package
docker build -t "$FRONTEND_IMAGE" .


# Push to Registry
docker push "$FRONTEND_IMAGE"
if [  $?+ -eq 0 ]; then
    docker rmi "$FRONTEND_IMAGE"
fi
