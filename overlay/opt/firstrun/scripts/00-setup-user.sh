#!/usr/bin/env bash

# Remove stupid "ubuntu" user

userdel -r ubuntu || true
userdel -r turtle || true

useradd -m -G tty,adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,lxd,netdev turtle
echo "turtle:turtle" | chpasswd
chsh -s /bin/bash turtle

rm -rf /etc/sudoers.d/90-cloud-init-users
echo "turtle ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10-turtle-user
