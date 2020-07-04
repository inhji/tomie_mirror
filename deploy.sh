#!/usr/bin/env zsh

ssh -T tomie@glados << EOSSH
source ~/.zshrc
cd ~/tomie
git pull
./build.sh
sudo systemctl restart tomie
exit
EOSSH
