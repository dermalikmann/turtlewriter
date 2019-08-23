#!/usr/bin/env bash

apt update
cat /opt/firstrun/scripts/02-apt-packages.txt | xargs apt install -y >> /opt/firstrun/apt.log
