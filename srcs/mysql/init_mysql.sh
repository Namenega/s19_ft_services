#!/bin/ash

#Launch Telegraf en arrière plan (&)
telegraf &

#mysql_install_db = Initializes the MariaDB data directory and creates the system tables in the mysql database,
#if they do not exist
#
#--user = login user name to use for running mysqld.
#Files and directories created by mysqld will be owned by this user
#
#--ldata = path to the MariaDB data directory.
mysql_install_db --user=root --ldata=/var/lib/mysql

#--bootstrap = create the MySQL privilege tables without having to start a full MySQL server.
mysqld --user=root --bootstrap < /setup/bootstrap.sql

#Setting wordpress database
mysql --user=root wordpress < /wordpress.sql

#--skip-network = Do not listen for TCP/IP connections at all
#
#--datadir = mysql data directory
#
#--bind-adress = The IP address to bind to.
mysqld --user=root --console --skip-networking=0 --port=3306 --datadir=/var/lib/mysql --bind-address=0.0.0.0
