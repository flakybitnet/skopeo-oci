#!/bin/sh
set -eu

set -a
. .ci/lib.sh
set +a

echo && echo "Setting authentication for $HARBOR_REGISTRY"
authfile='/kaniko/.docker/config.json'
setRegistryAuth "$authfile" "$HARBOR_REGISTRY" "$HARBOR_CREDS"

image="$APP_NAME/$APP_NAME:$APP_VERSION"
dockerfile="./Dockerfile"

echo && echo "Building $image image"
executor -c ./ -f "$dockerfile" -d "$HARBOR_REGISTRY/$image" \
    --build-arg SKOPEO_VERSION="$SKOPEO_VERSION" \
    --build-arg CRED_HELPERS_DIR="$CRED_HELPERS_DIR"

echo && echo 'Done'

