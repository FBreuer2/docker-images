#!/bin/bash

PACKAGE_NAME="clu/apache2_http_with_ssh"
SHOULD_DELETE_DIR="y"

if [ ! -d "docker_root/tmp/" ]; then
    mkdir -p docker_root/tmp/
fi

# we don't want to generate a password
if [ "$1"=="no_pw_gen" ]; then

    # but there is no password supplied, so we generate one eitherway
    if [ ! -f "docker_root/tmp/password" ]; then
        PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)
        echo "root:"$PASSWORD > docker_root/tmp/password
        echo "couldn't find password file in " $PWD"/docker_root/tmp/password"
        SHOULD_DELETE_DIR="y"
    fi

    if [ "$2" != "" ]; then
        PASSWORD="$2"
        echo "root:"$PASSWORD > docker_root/tmp/password
        SHOULD_DELETE_DIR="n"
    else
        PASSWORD=$(cat docker_root/tmp/password)
        echo $PASSWORD > docker_root/tmp/password
        SHOULD_DELETE_DIR="n"
    fi
        

else
    PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)
    echo "root:"$PASSWORD > docker_root/tmp/password
    SHOULD_DELETE_DIR="y"
fi

docker build -t "$PACKAGE_NAME" .

echo "container="$PACKAGE_NAME
echo "sshpassword="$PASSWORD

if [ "$SHOULD_DELETE_DIR"=="y" ]; then
    rm -rf docker_root
fi
