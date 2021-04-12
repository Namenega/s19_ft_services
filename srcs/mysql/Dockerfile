# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Nathan <Nathan@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/15 16:07:33 by Nathan            #+#    #+#              #
#    Updated: 2021/04/07 17:04:24 by Nathan           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

############################
#     DOCKERFILE MYSQL     #
############################

FROM	alpine:3.12

LABEL	maintainer="namenega <namenega@student.s19.be>"

ARG		MYSQL_USERNAME
ARG		MYSQL_PASSWORD

VOLUME	[ "/var/lib/mysql" ]

#Port
EXPOSE	3306

#Update l'index des packages disponibles
RUN		apk update

#Upgrade les packages déjà installés
RUN		apk upgrade

#Ajouter des nouveaux packages, ou en upgrade dans le systeme actif
#
#Mariadb = free mysql
RUN		apk add mariadb mariadb-common mariadb-client


############################
#      SETUP TELEGRAF      #
############################

#To install a package from the edge/testing repository without changing your repository configuration file, use the command below.
#This will tell apk to use that particular repository.
#Bc Telegraf pas dispo sur le repo par defaut
RUN		apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

#/etc/ directory est le dossier oû il y a tous les fichiers de config du système
ADD		telegraf.conf /etc/telegraf/telegraf.conf


#############################
#        SETUP MYSQL        #
#############################

RUN		mkdir -p /run/mysqld && touch /run/mysqld/mysqld.sock
RUN		mkdir -p /setup
ADD		bootstrap.sql /setup/bootstrap.sql
ADD		init_mysql.sh /setup/init_mysql.sh

RUN		sed -i "s/MYSQL_USERNAME/$MYSQL_USERNAME/g" /setup/bootstrap.sql
RUN		sed -i "s/MYSQL_PASSWORD/$MYSQL_PASSWORD/g" /setup/bootstrap.sql


#############################
#       LAUNCH SCRIPT       #
#############################

CMD		[ "/bin/ash", "/setup/init_mysql.sh" ]
