#!/usr/bin/env bash
while timedatectl status | grep -q synchronized:.*no
do
    echo "no ntp yet"
    read -t 5
done
echo "ntp found"
