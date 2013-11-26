#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
./cleanTmp.sh
cd $DIR/../tmp
wget --no-check-certificate https://go.googlecode.com/files/go1.2rc5.linux-amd64.tar.gz
tar -xf go1.2rc5.linux-amd64.tar.gz
sudo cp -rf go /usr/local/go
if ! grep -q 'export GOROOT=/usr/local/go' '/etc/profile' ; then
    echo "$(cat <<'EOF'
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
EOF
    )" | sudo tee -a /etc/profile > /dev/null
fi
sudo apt-get install gcc
