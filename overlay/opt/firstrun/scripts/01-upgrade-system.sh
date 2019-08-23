#!/usr/bin/env bash

apt update >> /opt/firstrun/apt.log
apt upgrade -y >> /opt/firstrun/apt.log
