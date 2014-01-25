#!/usr/bin/env bash
# if you are in china,please put "203.208.48.145 go.googlecode.com" to /etc/hosts
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
./cleanTmp.sh
cd $DIR/../tmp
wget --no-check-certificate https://go.googlecode.com/files/go1.2.src.tar.gz
tar -xf go1.2.src.tar.gz
sudo cp -rf go /usr/local/go
if ! grep -q 'export GOROOT=/usr/local/go' '/etc/profile' ; then
    echo "$(cat <<'EOF'
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
EOF
    )" | sudo tee -a /etc/profile > /dev/null
fi
sudo apt-get install gcc
cd /usr/local/go/src
sudo ./make.bash
