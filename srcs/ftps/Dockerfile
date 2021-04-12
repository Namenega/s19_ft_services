# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Nathan <Nathan@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/27 09:59:03 by Nathan            #+#    #+#              #
#    Updated: 2021/04/07 15:55:37 by Nathan           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

###########################
#     DOCKERFILE FTPS     #
###########################

FROM	alpine:3.12

LABEL	maintainer="namenega <namenega@student.s19.be>"

ARG		EXTERNAL_IP
ARG		FTPS_USERNAME
ARG		FTPS_PASSWORD

ENV		EXTERNAL_IP=${EXTERNAL_IP}

#Ports
EXPOSE	21 30000-30004

#Update l'index des packages disponibles
RUN		apk update

#Upgrade les packages déjà installés
RUN		apk upgrade

#Ajouter des nouveaux packages, ou en upgrade dans le systeme actif
#
#Openssl = toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.
RUN		apk add openssl

#Pure-FTPd is a free (BSD), secure, production-quality and standard-conformant FTP server.
RUN		apk add pure-ftpd \
		--repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
		#Install packages with untrusted signature or no signature
		--allow-untrusted


############################
#      SETUP TELEGRAF      #
############################

#To install a package from the edge/testing repository without changing your repository configuration file, use the command below.
#This will tell apk to use that particular repository.
#Bc Telegraf pas dispo sur le repo par defaut
RUN		apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

#/etc/ directory est le dossier oû il y a tous les fichiers de config du système
ADD		telegraf.conf /etc/telegraf/telegraf.conf

#Créer un user et ne pas lui mettre de password (-D)
RUN		adduser -D ${FTPS_USERNAME}

#Associer un wordpass au user nouvellement créé
RUN		echo "${FTPS_USERNAME}:${FTPS_PASSWORD}" | chpasswd

#Créer un directory pour setup une clé ssl privée
RUN		mkdir -p /etc/ssl/private

#Créer une nvlle clé
RUN		openssl req -newkey rsa:2048 \
		#Clé non cryptée
		-nodes \
		#Clé écrite dans filename
		-keyout /etc/ssl/private/pure-ftpd.pem \
		#Certificat auto-certifié
		-x509 \
		#Pour une durée de 365 days
		-days 365 \
		#Fichier de sortie
		-out /etc/ssl/private/pure-ftpd.pem \
		#Specific data : Country_Name=Belgium
		-subj '/CN=BE'


#############################
#       LAUNCH SCRIPT       #
#############################

RUN		mkdir -p /setup
ADD		init_ftps.sh /setup/init_ftps.sh

CMD		[ "/bin/ash", "/setup/init_ftps.sh" ]
