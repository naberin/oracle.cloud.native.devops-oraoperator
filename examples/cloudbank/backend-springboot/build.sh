#!/bin/bash
## Copyright (c) 2021 Oracle and/or its affiliates.
## Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# building image string
if [ -z "$BACKEND_IMAGE" ]; then
  REGISTRY=$(jq -r .lab.docker_registry $CB_STATE_DIR/state.json)
  IMG=$(jq -r .app.backend.image.name $CB_STATE_DIR/state.json)
  VERSION=$(jq -r .app.backend.iamge.version $CB_STATE_DIR/state.json)
  export BACKEND_IMAGE="$REGISTRY/$IMG:$VERSION"
fi

# package
mvn clean package spring-boot:repackage

# build
docker build -t $BACKEND_IMAGE .

# push
docker push "$BACKEND_IMAGE"

# cleanup
if [  $? -eq 0 ]; then
    docker rmi "$IMAGE"
fi


#export IS_CREATE_REPOS=$1
#if [ -z "IS_CREATE_REPOS" ]; then
#    echo "not creating OCIR repos"
#else
#    echo "creating OCIR repos and setting to public"
#    if [ -z "$COMPARTMENT_OCID" ]; then
#        echo "COMPARTMENT_OCID not set. Will get it with state_get"
#        export COMPARTMENT_OCID=$(state_get COMPARTMENT_OCID)
#    fi
#    if [ -z "RUN_NAME" ]; then
#        echo "RUN_NAME not set. Will get it with state_get"
#        export RUN_NAME=$(state_get RUN_NAME)
#    fi
##    RUN_NAME is randomly generated name from workshop, eg gd4930131
#    oci artifacts container repository create --compartment-id "$COMPARTMENT_OCID" --display-name "$RUN_NAME/$IMAGE_NAME" --is-public true
#fi

