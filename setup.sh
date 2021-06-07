#!/usr/bin/env bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Nathan <Nathan@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/27 14:53:30 by Nathan            #+#    #+#              #
#    Updated: 2021/02/27 16:02:56 by Nathan           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RED='\033[0;31m'
GREEN='\033[0;32m'
LBLUE='\033[1;34m'
NC='\033[0m'

echo "\n${LBLUE}###########"
echo "#  START  #"
echo "###########${NC}\n"

#
#UNCOMMENT IF NEEDED
#

echo "\n### ${GREEN}Delete srcs${NC} ###\n"
#kubectl delete -f srcs/.

echo "\n### ${GREEN}Stop minikube if running${NC} ###\n"

minikube stop

echo "\n### ${GREEN}Delete previous services${NC} ###\n"

minikube delete --all

#
#LOGIN & WP
#

FTPS_USERNAME=ftps
FTPS_PASSWORD=pass
MYSQL_USERNAME=mysql
MYSQL_PASSWORD=pass
SSH_USERNAME=ssh
SSH_PASSWORD=pass
GRAFANA_USERNAME=grafana
GRAFANA_PASSWORD=pass


#
#STARTING MINIKUBE
#AVEC ADDONS METALLB & DASHBOARD
#SOUS VIRTUAL BOX
#

echo "\n### ${GREEN}Start minikube in VBox${NC} ###\n"

minikube start --driver=virtualbox --memory='3000' --disk-size 10000MB --addons dashboard --addons metallb


#
#ENTER IN DOCKER DAEMON'S MINIKUBE
#

echo "\n\n\n${RED}#################################################"
echo "###${NC} 5. ${GREEN}Launch Docker environment for minikube${RED} ###"
echo "#################################################${NC}\n"

eval $(minikube docker-env)


#
#BUILDING IMAGES
#


###########################
##### MetalLB Service #####
###########################

echo "\n### ${GREEN}MetalLB Creating Object${NC} ###\n"

kubectl apply -f srcs/metallb.yaml


#########################
##### MySQL Service #####
#########################

echo "\n\n${LBLUE}##################"
echo "# Starting MySQL #"
echo "##################${NC}\n"

echo "\n### ${GREEN}MySQL docker build${NC} ###\n"

docker build -t mysql_service srcs/mysql/. --build-arg MYSQL_USERNAME=$MYSQL_USERNAME --build-arg MYSQL_PASSWORD=$MYSQL_PASSWORD

echo "\n### ${GREEN}MySQL Creating Object${NC} ###\n"

kubectl apply -f srcs/mysql/mysql.yaml


########################
##### FTPS Service #####
########################

echo "\n${LBLUE}#################"
echo "# Starting FTPS #"
echo "#################${NC}\n"

echo "\n### ${GREEN}FTPS docker build${NC} ###\n"

docker build -t ftps_service srcs/ftps/. --build-arg EXTERNAL_IP=192.168.99.240 --build-arg FTPS_USERNAME=$FTPS_USERNAME --build-arg FTPS_PASSWORD=$FTPS_PASSWORD

echo "\n### ${GREEN}FTPS Creating Object${NC} ###\n"

kubectl apply -f srcs/ftps/ftps.yaml


##############################
##### PhpMyAdmin Service #####
##############################

echo "\n\n${LBLUE}#######################"
echo "# Starting PhpMyAdmin #"
echo "#######################${NC}\n"

echo "\n### ${GREEN}PhpMyAdmin docker build${NC} ###\n"

docker build -t phpmyadmin_service srcs/phpmyadmin/.

echo "\n### ${GREEN}PhpMyAdmin Creating Object${NC} ###\n"

kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml


#############################
##### Wordpress Service #####
#############################

echo "\n\n${LBLUE}######################"
echo "# Starting Wordpress #"
echo "######################${NC}\n"

echo "\n### ${GREEN}Wordpress docker build${NC} ###\n"

docker build -t wordpress_service srcs/wordpress/.

echo "\n### ${GREEN}Wordpress Creating Object${NC} ###\n"

kubectl apply -f srcs/wordpress/wordpress.yaml


#########################
##### NGINX Service #####
#########################

echo "\n\n${LBLUE}##################"
echo "# Starting Nginx #"
echo "##################${NC}\n"

echo "\n### 11. ${GREEN}Nginx docker build${NC} ###\n"

docker build -t nginx_service srcs/nginx/. --build-arg SSH_USERNAME=$SSH_USERNAME --build-arg SSH_PASSWORD=$SSH_PASSWORD

echo "\n### ${GREEN}Nginx Creating Object${NC} ###\n"

kubectl apply -f srcs/nginx/nginx.yaml


############################
##### InfluxDB Service #####
############################

echo "\n\n${LBLUE}#####################"
echo "# Starting InfluxDB #"
echo "#####################${NC}\n"

echo "\n### ${GREEN}InfluxDB docker build${NC} ###\n"

docker build -t influxdb_service srcs/influxdb/.

echo "\n### ${GREEN}InfluxDB Creating Object${NC} ###\n"

kubectl apply -f srcs/influxdb/influxdb.yaml


###########################
##### Grafana Service #####
###########################

echo "\n\n${LBLUE}####################"
echo "# Starting Grafana #"
echo "####################${NC}\n"

echo "\n### ${GREEN}Grafana docker build${NC} ###\n"

docker build -t grafana_service srcs/grafana/.

echo "\n### ${GREEN}Grafana Creating Object${NC} ###\n"

kubectl apply -f srcs/grafana/grafana.yaml


#
#LET'S GIVE TIME FOR THE SERVICES TO START
#

sleep 10

#
#GET WORDPRESS DB AND PUT IT IN srcs/mysql/wordpress.sql
#

echo "\n${LBLUE}Setting wordpress.sql ...${NC}"

kubectl exec -i $(kubectl get pods | grep -o "\S*mysql\S*") -- mysql wordpress -u root < srcs/mysql/wordpress.sql

#
#OPENING DASHBOARD
#

echo "\n${LBLUE}######################"
echo "# Lauching Dashboard #"
echo "######################${NC}\n"

minikube dashboard
