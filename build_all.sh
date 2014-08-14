#!/bin/sh
##
# base image (http)
###
cd apache2_http
./build.sh
cd ..

##
# base image (http/ssh)
###
cd apache2_http_with_ssh
./build.sh
cd ..

##
# owncloud (http) and owncloud (http/ssh)
###
cd apache2_owncloud
./build.sh
./build.sh with_ssh
