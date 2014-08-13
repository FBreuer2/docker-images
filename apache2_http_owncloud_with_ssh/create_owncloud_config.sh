#!/bin/sh
if [ ! -d "docker_root/etc/apache2/sites-enabled" ]; then
    mkdir -p docker_root/etc/apache2/sites-enabled
fi

if [ ! -d "docker_root/etc/apache2/sites-available" ]; then
    mkdir -p docker_root/etc/apache2/sites-available
fi

OWNCLOUD_SERVER_NAME_DOCKER="#ServerName "+$OWNCLOUD_SERVER_NAME_DOCKER
OWNCLOUD_SERVER_ADMIN_DOCKER="#ServerAdmin "+$OWNCLOUD_SERVER_ADMIN_DOCKER

OWNCLOUD_CONFIG_FILE="023-owncloud.conf"

if [ -f "$OWNCLOUD_CONFIG_FILE" ]; then 
    rm "$OWNCLOUD_CONFIG_FILE"
fi

echo '<VirtualHost *:'$OWNCLOUD_SERVER_PORT_DOCKER'>' >> "$OWNCLOUD_CONFIG_FILE"
echo "" >> "$OWNCLOUD_CONFIG_FILE"
echo "      "$OWNCLOUD_SERVER_NAME_DOCKER >> "$OWNCLOUD_CONFIG_FILE"
echo "      "$OWNCLOUD_SERVER_ADMIN_DOCKER >> "$OWNCLOUD_CONFIG_FILE"
echo "      DocumentRoot /var/www/html" >> "$OWNCLOUD_CONFIG_FILE"
echo "" >> "$OWNCLOUD_CONFIG_FILE"
echo "      <Directory /var/www/html>" >> "$OWNCLOUD_CONFIG_FILE"
echo "          Options Indexes FollowSymLinks MultiViews" >> "$OWNCLOUD_CONFIG_FILE"
echo "          AllowOverride All" >> "$OWNCLOUD_CONFIG_FILE"
echo "          Require all granted" >> "$OWNCLOUD_CONFIG_FILE"
echo "      </Directory>" >> "$OWNCLOUD_CONFIG_FILE"
echo "" >> "$OWNCLOUD_CONFIG_FILE"
echo '      ErrorLog ${APACHE_LOG_DIR}/error.log' >> "$OWNCLOUD_CONFIG_FILE"
echo '      CustomLog ${APACHE_LOG_DIR}/access.log combined' >> "$OWNCLOUD_CONFIG_FILE"
echo "" >> "$OWNCLOUD_CONFIG_FILE"
echo "</VirtualHost>" >> "$OWNCLOUD_CONFIG_FILE"

cp "$OWNCLOUD_CONFIG_FILE" docker_root/etc/apache2/sites-enabled/
cp "$OWNCLOUD_CONFIG_FILE" docker_root/etc/apache2/sites-available/
