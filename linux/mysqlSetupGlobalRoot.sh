#!/usr/bin/env bash
echo -n NewPassword:
read -s password
echo
echo -n ReNewPassword:
read -s repassword
echo
if [ "$password" != "$repassword" ];then
    echo 'two password not equal'
fi
echo 'your mysql local root password:'
mysql -uroot -p -e "CREATE USER 'root'@'%' IDENTIFIED BY '$password';GRANT ALL PRIVILEGES ON "'*.*'" TO 'root'@'%' WITH GRANT OPTION;"
