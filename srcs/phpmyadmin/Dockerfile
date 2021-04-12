# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Nathan <Nathan@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/27 09:53:49 by Nathan            #+#    #+#              #
#    Updated: 2021/04/07 17:03:43 by Nathan           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#################################
#     DOCKERFILE PHPMYADMIN     #
#################################

FROM	alpine:3.12

LABEL	maintainer="namenega <namenega@student.s19.be>"

#Port
EXPOSE	5000

#Update l'index des packages disponibles
RUN		apk update

#Upgrade les packages déjà installés
RUN		apk upgrade

#Ajouter des nouveaux packages, ou en upgrade dans le systeme actif
#
#Openrc = dependency-based init system for Unix-like computer operating systems
RUN		apk add openrc
RUN		apk add nginx

#Installation de php
RUN		apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib \
		php7-curl php7-mbstring php7-json php7-session


############################
#      SETUP TELEGRAF      #
############################

#To install a package from the edge/testing repository without changing your repository configuration file, use the command below.
#This will tell apk to use that particular repository.
#Bc Telegraf pas dispo sur le repo par defaut
RUN		apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

#/etc/ directory est le dossier oû il y a tous les fichiers de config du système
ADD		telegraf.conf /etc/telegraf/telegraf.conf


##################################
#        SETUP PHPMYADMIN        #
##################################

RUN		mkdir -p /var/www/phpmyadmin
ADD		phpmyadmin /var/www/phpmyadmin

RUN		mkdir -p /run/nginx
RUN		rm /etc/nginx/conf.d/default.conf
ADD		phpmyadmin.conf /etc/nginx/conf.d/phpmyadmin.conf


#############################
#       LAUNCH SCRIPT       #
#############################

ADD		init_phpmyadmin.sh /setup/init_phpmyadmin.sh

CMD		[ "/bin/ash", "/setup/init_phpmyadmin.sh" ]
