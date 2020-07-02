#!/usr/bin/env zsh

ssh -T tomie@glados << EOSSH
cd ~/tomie
git pull
./build.sh
exit
EOSSH
#ssh -T glados systemctl restart tomie
