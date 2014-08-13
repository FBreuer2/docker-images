#!/bin/bash

PACKAGE_NAME="clu/apache2_http_owncloud_with_ssh"
SHOULD_DELETE_DIR="n"

# clear old artefacts
if [ -d "html" ]; then
    rm -rf html
fi

if [ "$1" == "-h" ]; then
    echo "usage: ./build.sh <virtualname> <serverport>  <admin_adress>"
    echo "default: ./build will set no name and adress but port=80"
    echo "real example: ./build www.example.com 80 admin@example.com"
fi


# FIXME: Figure this out

export OWNCLOUD_SERVER_NAME_DOCKER="asdsad.asdasd"
export OWNCLOUD_SERVER_PORT_DOCKER="80"
export OWNCLOUD_SERVER_ADMIN_DOCKER="asdasda@asdasd.asd"



# download owncloud if we don't have a backup in the owncloud directory
if [ ! -d "owncloud" ]; then
    wget -q -c "$OWNCLOUD_LINK"

    tar --bzip2 --atime-preserve -xf owncloud-7*
fi

mkdir html
cp -r owncloud/* html

source ./create_owncloud_config.sh

docker build -t "$PACKAGE_NAME" .
echo "container="$PACKAGE_NAME
