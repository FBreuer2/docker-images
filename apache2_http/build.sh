#!/bin/bash

PACKAGE_NAME="clu/apache2_http"
SHOULD_DELETE_DIR="n"

docker build -t "$PACKAGE_NAME" .
echo "container="$PACKAGE_NAME

