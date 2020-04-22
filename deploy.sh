#!/usr/bin/env bash

ssh -T root@inhji.de << EOSSH
su tomie
cd /opt/tomie
git pull
./build.sh
exit
EOSSH
ssh -T root@inhji.de systemctl restart tomie
