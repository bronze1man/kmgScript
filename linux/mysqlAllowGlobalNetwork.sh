#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../
backupDir=`pwd`/backup/`date +%Y-%m-%d_%H-%M-%S`_etc_mysql
mkdir -p $backupDir

cp /etc/mysql/my.cnf $backupDir
if grep -q '^bind-address.*=' /etc/mysql/my.cnf ;then
    sudo sed -i 's/^bind-address.*$/bind-address = 0.0.0.0/g' /etc/mysql/my.cnf
else
    echo 'bind-address = 0.0.0.0' | sudo tee -a /etc/mysql/my.cnf > /dev/null
fi

sudo service mysql restart

