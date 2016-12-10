#!/bin/bash

# Updating repository
sudo apt-get -y update

# Installing Nodejs and npm
sudo apt-get install curl
sudo curl https://raw.github.com/creationix/nvm/master/install.sh | sh
sudo nvm install v0.10.16
sudo apt-get install npm

#Installing Express
sudo npm install -g express

# Installing MySQL and it's dependencies, Also, setting up root password for MySQL as it will prompt to enter the password during installation
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server