# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Nathan <Nathan@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/27 09:56:03 by Nathan            #+#    #+#              #
#    Updated: 2021/04/07 15:40:17 by Nathan           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

############################
#     DOCKERFILE NGINX     #
############################

FROM	alpine:3.12

LABEL	maintainer="namenega <namenega@student.s19.be>"

ARG SSH_USERNAME
ARG SSH_PASSWORD

#Ports
#SSH   : 22
#HTTP  : 80
#HTTPS : 443
EXPOSE 22 80 443

#Update l'index des packages disponibles
RUN apk update

#Upgrade les packages déjà installés
RUN apk upgrade

#Ajouter des nouveaux packages, ou en upgrade dans le systeme actif
#
#Openssh = premier connectivity tool for remote login with the SSH protocol
RUN apk add openssh
RUN apk add nginx

#Openssl = toolkit for the Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.
RUN apk add openssl


############################
#      SETUP TELEGRAF      #
############################

#To install a package from the edge/testing repository without changing your repository configuration file, use the command below.
#This will tell apk to use that particular repository.
#Bc Telegraf pas dispo sur le repo par defaut
RUN apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

#/etc/ directory est le dossier oû il y a tous les fichiers de config du système
ADD telegraf.conf /etc/telegraf/telegraf.conf

#Créer un user et ne pas lui mettre de password (-D)
RUN adduser -D $SSH_USERNAME

#Associer un wordpass au user nouvellement créé
RUN echo "$SSH_USERNAME:$SSH_PASSWORD" | chpasswd

#Ssh-keygen génère, gère et convertit des clés d'authentification
#-A = pour chaque type de clés, pour lesquelles une clé hote n'existe pas,
#ça génère un "key file path" par defaut
RUN ssh-keygen -A


#############################
#         SETUP SSL         #
#############################

#Créer un directory pour setup ssl
RUN mkdir -p /setup/ssl

#Créer une nvlle clé
RUN openssl req -newkey rsa:2048 \
#Clé non cryptée
				-nodes \
#Clé écrite dans filename
				-keyout /setup/ssl/certificate.key \
#Certificat auto-certifié
				-x509 \
#Pour une durée de 365 days
				-days 365 \
#Fichier de sortie
				-out /setup/ssl/certificate.crt \
#Specific data : Country_Name=Belgium
				-subj '/CN=BE'


#############################
#           INDEX           #
#############################

#defaut root directory of web server
RUN mkdir -p /var/www/localhost

#setting a home page
ADD index.html /var/www/localhost/index.html


############################
#        NGINX.CONF        #
############################

#create a directory for temporary running files & nginx
RUN mkdir -p /run/nginx

#delete le default.conf et replaced by nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
ADD nginx.conf /etc/nginx/conf.d/nginx.conf


#############################
#       LAUNCH SCRIPT       #
#############################

ADD init_nginx.sh /setup/init_nginx.sh

RUN chmod +x /setup/init_nginx.sh

CMD ["bin/ash", "/setup/init_nginx.sh"]
