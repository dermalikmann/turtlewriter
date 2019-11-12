#!/usr/bin/env bash

cp /opt/firstrun/scripts/20-bashrc.txt /home/turtle/.bashrc
sed -i "s/<<<HOSTNAME>>>/`hostname`/" /home/turtle/.bashrc
