# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: Nathan <Nathan@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/27 10:02:34 by Nathan            #+#    #+#              #
#    Updated: 2021/03/09 13:43:22 by Nathan           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine:3.12

LABEL	maintainer="namenega <namenega@student.s19.be>"

VOLUME	[ "/var/lib/influxdb" ]

EXPOSE	8086

RUN		apk update
RUN		apk upgrade

RUN		apk add influxdb

RUN		apk add telegraf --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

ADD		telegraf.conf /etc/telegraf/telegraf.conf

ADD		influxdb.conf /etc/influxdb/influxdb.conf

RUN		mkdir -p /setup
ADD		init_influxdb.sh /setup/init_influxdb.sh

CMD		[ "/bin/ash", "/setup/init_influxdb.sh" ]
