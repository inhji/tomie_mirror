#!/usr/bin/env zsh

ssh -T root@inhji.de << EOSSH
su tomie
source ~/.zshrc
cd /opt/tomie
git pull
./build.sh
exit
EOSSH
ssh -T root@inhji.de systemctl restart tomie
