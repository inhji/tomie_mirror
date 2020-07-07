#!/usr/bin/env zsh

echo "Build starting!"
echo "--------------------------"
ssh -T tomie@glados << EOSSH
source ~/.zshrc
cd ~/tomie
git pull
./build.sh
EOSSH
echo "Build complete, restarting..."
ssh -T tomie@glados sudo systemctl restart tomie
