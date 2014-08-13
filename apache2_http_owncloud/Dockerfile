FROM clu/apache2_http

MAINTAINER Florian Breuer "uhdnm@student.kit.edu"

#############################################################################################################
#                               add owncloud source                                                         #
#                               and fix rights                                                              #
#############################################################################################################
ADD html /var/www/html
RUN chown -R www-data /var/www 

RUN rm /var/www/html/index.html


#############################################################################################################
#                               merge configuration                                                         #
#                                                                                                           #
#############################################################################################################
ADD docker_root /

RUN rm /etc/apache2/sites-enabled/000-default.conf

RUN apache2ctl restart

