#!bin/ash

#Launch Telegraf en arrière plan (&)
telegraf &

php-fpm7

#Permet de run NGINX en avant-plan
nginx -g 'daemon off;'
