-- reload privileges tables without restarting
FLUSH PRIVILEGES;

-- create database if it doesn't exist yet
CREATE DATABASE IF NOT EXISTS wordpress;

-- create user and grant privileges everywhere
CREATE USER 'MYSQL_USERNAME'@'%' IDENTIFIED BY 'MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'MYSQL_USERNAME'@'%'IDENTIFIED BY 'MYSQL_PASSWORD' WITH GRANT OPTION;

-- create user and grant privileges for wordpress
CREATE USER 'wp_user'@'%' IDENTIFIED BY 'wp_pass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wp_user'@'%' IDENTIFIED BY 'wp_pass' WITH GRANT OPTION;

-- reload privileges tables without restarting
FLUSH PRIVILEGES;
