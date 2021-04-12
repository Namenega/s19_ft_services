#!/bin/ash

#Launch Telegraf en arrière plan (&)
telegraf &

#set le homepath vers le serveur
grafana-server --homepath=/grafana
