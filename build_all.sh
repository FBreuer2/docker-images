#!/bin/sh
##
# base image (http)
###
cd apache2_http
sh build.sh
cd ..

##
# base image (http/ssh)
###
cd apache2_http_with_ssh
sh build.sh
cd ..

##
# owncloud (http)
###

OWNCLOUD_LINK='https://download.owncloud.org/community/owncloud-7.0.1.tar.bz2'

cd apache2_http_owncloud
sh build.sh
cd ..

##
# owncloud (http/ssh)
###

cd apache2_http_owncloud_with_ssh
sh build.sh
cd ..


