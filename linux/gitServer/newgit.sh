#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

target=$1
sudo mkdir -p $target
if [ ! -d $target ]
then
    echo 'can not create dir 不能创建目录'
    exit
fi
sudo chown git:git $target
cd $target
sudo -u git git init --bare
