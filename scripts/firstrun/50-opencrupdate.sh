#!/usr/bin/env sh

mkdir -p /tmp/opencrupdate
cd /tmp/opencrupdate
rm -rf ./*

wget https://github.com/ROBOTIS-GIT/OpenCR-Binaries/raw/master/turtlebot3/ROS1/latest/opencr_update.tar.bz2
tar xvfj opencr_update.tar.bz2
cd ./opencr_update
OPENCR_PORT=/dev/ttyACM0
OPENCR_MODEL=burger
./update.sh $OPENCR_PORT $OPENCR_MODEL.opencr
