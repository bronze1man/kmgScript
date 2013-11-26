#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/../
backupDir=`pwd`/backup/`date +%Y-%m-%d_%H-%M-%S`/etc/network
mkdir -p $backupDir
cp /etc/network/interfaces $backupDir
if !(echo "$1" | grep -qP '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') ;then
    echo 'argument 1(you ip) is not a ip'
    exit
fi
if !(echo "$2" | grep -qP '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') ;then
    echo 'argument 2(gateway ip) is not a ip'
    exit
fi

if !(echo "$3" | grep -qP '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}') ;then
    echo 'argument 3(dns ip) is not a ip'
    exit
fi

IP=$1
GATEWAY=$2
DNSIP=$3
    echo "$(cat <<EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet static
    address $IP
    netmask 255.255.255.0
    gateway $GATEWAY
    dns-nameservers $DNSIP 8.8.8.8
EOF
)" | sudo tee /etc/network/interfaces > /dev/null

sudo /etc/init.d/networking restart
