#!/bin/ash

#Launch Telegraf en arrière plan (&)
telegraf &

#Application des protocoles de sécurité
#ftpd est un exécutable
/usr/sbin/pure-ftpd -Y 2 -p 30000:30004 -P $EXTERNAL_IP
