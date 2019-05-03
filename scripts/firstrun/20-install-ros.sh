#!/usr/bin/env bash

echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 || \
	sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 || \
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

apt update

apt install sudo apt install ros-melodic-ros-base python-rosinstall python-rosinstall-generator python-wstool

echo "source /opt/ros/melodic/setup.bash" >> /home/turtle/.bashrc
echo "source /opt/ros/melodic/setup.zsh" >> /home/turtle/.zshrc

chown turtle:turtle /home/turtle/.bashrc
chown turtle:turtle /home/turtle/.zshrc

rosdep init
sudo -u turtle rosdep update
sudo -u turtle git clone --recurse-submodules -j8 https://github.com/ovgu-FINken/DrivingSwarm /home/turtle/driving_swarm

apt install install ros-kinetic-rosserial-python ros-kinetic-tf

rosrun turtlebot3_bringup create_udev_rules
