#!/bin/bash
echo-e "\033[0;35m"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
echo " #####   ####        ####        ####  ####    ######    ##########  ####    ####  ###########   ####  ####";
echo " ######  ####       ######       #### ####    ########   ##########  ####    ####  ####   ####   #### ####";
echo " ####### ####      ###  ###      ########    ####  ####     ####     ####    ####  ####   ####   ########";   
echo " #### #######     ##########     ########   ####    ####    ####     ####    ####  ###########   ########";
echo " ####  ######    ############    #### ####   ####  ####     ####     ####    ####  ####  ####    #### ####";  
echo " ####   #####   ####      ####   ####  ####   ########      ####     ############  ####   ####   ####  ####";
echo " ####    ####  ####        ####  ####   ####    ####        ####     ############  ####    ####  ####   ####";
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++";
echo -e '\e[36mTwitter:\e[39m' https://twitter.com/NakoTurk
echo -e '\e[36mGithub: \e[39m' https://github.com/okannako
echo -e "\e[0m"

sleep 5

cd

echo '+++++++++++++++++++++++++++++++++++++++++++++++++++'
echo -e "Your node name: \e[1m\e[32m$NODENAME\e[0m"
echo -e "Your wallet name: \e[1m\e[32m$WALLET\e[0m"
echo '+++++++++++++++++++++++++++++++++++++++++++++++++++'

sudo apt update && sudo apt upgrade -y
sudo apt-get -y install libssl-dev && apt-get -y install cmake build-essential git wget jq make gcc unzip ca-certificates curl gnupg lsb-release

curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
sudo chmod 666 /var/run/docker.sock
docker pull nulink/nulink:latest

wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.10.24-972007a5.tar.gz
tar -xvzf geth-linux-amd64-1.10.24-972007a5.tar.gz
cd geth-linux-amd64-1.10.24-972007a5/
./geth account new --keystore ./keystore

cd /root
mkdir nulink

echo 'INSTALLATION IS COMPLETE'

