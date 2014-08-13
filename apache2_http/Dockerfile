FROM phusion/baseimage:0.9.12

MAINTAINER Florian Breuer "uhdnm@student.kit.edu"

# Set correct environment variables.
ENV HOME /root

# shell can't be interacted with
RUN DEBIAN_FRONTEND=noninteractive


#############################################################################################################
#                               update package information                                                  #
#                               and install package files                                                   #
#############################################################################################################

RUN apt-get update
RUN apt-get install -y apache2 php5 php5-gd php-xml-parser php5-intl php5-sqlite smbclient curl libcurl3 php5-curl bzip2 wget openssl ssl-cert


#############################################################################################################
#                               add service run scripts and expose ports                                    #
#                                                                                                           #
#############################################################################################################

# add services
ADD service /etc/service


#############################################################################################################
#                               configure service                                                           #
#                                                                                                           #
#############################################################################################################
RUN chown -R www-data /var/www 
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
EXPOSE 80


#############################################################################################################
#                               disable ssh                                                                 #
#                                                                                                           #
#############################################################################################################
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/sbin/my_init"]
