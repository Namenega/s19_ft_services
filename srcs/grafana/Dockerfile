# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Nathan <Nathan@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/27 09:51:44 by Nathan            #+#    #+#              #
#    Updated: 2021/04/22 12:26:51 by Nathan           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

##############################
#     DOCKERFILE GRAFANA     #
##############################

FROM	alpine:3.12

LABEL 	maintainer="namenega <namenega@student.s19.be>"

#Ports
EXPOSE	3000

#Update l'index des packages disponibles
RUN		apk update

#Upgrade les packages déjà installés
RUN		apk upgrade

#Ajouter des nouveaux packages, ou en upgrade dans le systeme actif
#
#wget = programme en ligne de commande non interactif de téléchargement de fichiers depuis le Web
RUN		apk add wget


############################
#      SETUP TELEGRAF      #
############################

#To install a package from the edge/testing repository without changing your repository configuration file, use the command below.
#This will tell apk to use that particular repository.
#Bc Telegraf pas dispo sur le repo par defaut
RUN		apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

#libc6 = compatibility libraries for glibc as well as symlinks /lib64 to /lib
RUN		apk add libc6-compat --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main

#/etc/ directory est le dossier oû il y a tous les fichiers de config du système
ADD		telegraf.conf /etc/telegraf/telegraf.conf


###########################
#      SETUP GRAFANA      #
###########################

ADD		https://dl.grafana.com/oss/release/grafana-7.4.0.linux-amd64.tar.gz /
RUN		tar -zxvf grafana-7.4.0.linux-amd64.tar.gz
RUN		rm -f grafana-7.4.0.linux-amd64.tar.gz
RUN		mv grafana-7.4.0/ grafana/
RUN		mv grafana/bin/* /usr/local/bin/
#RUN		mkdir -p /grafana/data
ADD		grafana.db /grafana/data/grafana.db
#RUN 	chmod 777 /grafana/data/
RUN 	chmod 640 /grafana/data/grafana.db


#############################
#       LAUNCH SCRIPT       #
#############################

RUN		mkdir -p /setup
ADD		init_grafana.sh /setup/init_grafana.sh

CMD		[ "/bin/ash", "/setup/init_grafana.sh" ]
