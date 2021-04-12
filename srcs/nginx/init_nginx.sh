#!bin/ash

#Launch Telegraf en arrière plan (&)
telegraf &

#Application des protocoles de sécurité
#sshd est un exécutable
/usr/sbin/sshd

#Permet de run NGINX en avant-plan
nginx -g "daemon off;"
