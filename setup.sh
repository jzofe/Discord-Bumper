#!/bin/bash


OS=$(uname)


if [ "$OS" == "Linux" ] && [ -f /etc/lsb-release ]; then
    echo "OS : Ubuntu"
    sudo apt-get install -y npm
    sudo npm i cfonts -g
elif [ "$OS" == "Linux" ] && [ -f /etc/redhat-release ]; then
    echo "OS : CentOS"
    sudo yum install -y npm
    sudo npm i cfonts -g

elif [ "$OS" == "Android" ]; then
    echo "OS : Termux"
    pkg install npm
    npm i cfonts -g
else
    echo "[-]"
fi
