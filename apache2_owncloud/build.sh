#!/bin/bash

OWNCLOUD_LINK='https://download.owncloud.org/community/owncloud-7.0.1.tar.bz2'
SHOULD_DELETE_DIR="n"

#### standard build can be changed with "with_ssh" as first argument
BUILD_DIR="without_ssh"

# clear old artefacts
if [ -d "html" ]; then
    rm -rf html
fi

if [ -d "docker_root" ]; then
    rm -rf docker_root
fi

if [ "$1" == "with_ssh" ]; then
    PACKAGE_NAME="clu/apache2_http_owncloud_with_ssh"
    BUILD_DIR="with_ssh"
    echo "Building with ssh in $BUILD_DIR"
fi

if [ "$1" == "" ]; then
    PACKAGE_NAME="clu/apache2_http_owncloud"
    BUILD_DIR="without_ssh"
    echo "Building without ssl in $BUILD_DIR"
fi

# FIXME: Figure this out
export OWNCLOUD_SERVER_NAME_DOCKER=""
export OWNCLOUD_SERVER_PORT_DOCKER="80"
export OWNCLOUD_SERVER_ADMIN_DOCKER=""



# download owncloud if we don't have a backup in the owncloud directory
if [ ! -d "html" ]; then
    wget -q -c "$OWNCLOUD_LINK"
    tar --bzip2 --atime-preserve -xf owncloud-7*
    mv -f owncloud html
fi


source create_owncloud_config.sh

cp -r html $BUILD_DIR 
cp -r docker_root $BUILD_DIR 

docker build -t "$PACKAGE_NAME" $BUILD_DIR

rm -rf $BUILD_DIR/docker_root
rm -rf $BUILD_DIR/html

echo "container="$PACKAGE_NAME
