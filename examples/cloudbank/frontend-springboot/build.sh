#!/bin/bash
## Copyright (c) 2021 Oracle and/or its affiliates.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# Retrieve image
if [ -z "$FRONTEND_IMAGE" ]; then
  DOCKER_REGISTRY=$(jq -r .lab.docker_registry $CB_STATE_DIR/state.json)
  IMG=$(jq -r .app.frontend.image.name $CB_STATE_DIR/state.json)
  VERSION=$(jq -r .app.frontend.image.version $CB_STATE_DIR/state.json)
  export FRONTEND_IMAGE="$DOCKER_REGISTRY/$IMG:$VERSION"
fi

# Build Application
mvn clean package
docker build -t "$FRONTEND_IMAGE" .

# Push to Registry
docker push "$FRONTEND_IMAGE"
if [  $?+ -eq 0 ]; then
    docker rmi "$FRONTEND_IMAGE"
fi
