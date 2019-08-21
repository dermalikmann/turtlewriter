#!/usr/bin/env bash

apt update
cat 02-apt-packages.txt | xargs apt install -y 
