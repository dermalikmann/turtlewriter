#!/usr/bin/env bash

# Remove stupid "ubuntu" user

userdel -r ubuntu || true
userdel -r turtle || true

useradd -m -G dialout,tty,adm,cdrom,sudo,dip,plugdev,lpadmin,sambashare turtle
echo "turtle" | chpasswd turtle
