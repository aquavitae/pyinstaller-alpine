#!/bin/bash

export PYTHON_VERSION=${1}
export ALPINE_VERSION=${2:-3.8}
export PYINSTALLER_TAG=${3:-v3.4}

REPO="aquavitae/pyinstaller-alpine:$PYTHON_VERSION-$ALPINE_VERSION"

echo "python: $PYTHON_VERSION"
echo "alpine: $ALPINE_VERSION"

docker build \
    --build-arg PYTHON_VERSION=$PYTHON_VERSION \
    --build-arg ALPINE_VERSION=$ALPINE_VERSION \
    --build-arg PYINSTALLER_TAG=$PYINSTALLER_TAG \
    -t $REPO .

docker push $REPO
