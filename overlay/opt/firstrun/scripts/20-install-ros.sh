#!/usr/bin/env bash

echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list
KEY=C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key $KEY || \
sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-key $KEY || \
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key $KEY

apt update >> /opt/firstrun/apt.log

apt install -y ros-melodic-ros-base python-rosinstall python-rosinstall-generator python-wstool python-catkin-tools  >> /opt/firstrun/apt.log

#echo "source /opt/ros/melodic/setup.bash" >> /home/turtle/.bashrc
#echo "source /opt/ros/melodic/setup.zsh" >> /home/turtle/.zshrc

cp /opt/firstrun/scripts/20-bashrc.txt /home/turtle/.bashrc

chown turtle:turtle /home/turtle/.bashrc
chown turtle:turtle /home/turtle/.zshrc

sudo rosdep init
sudo -Hu turtle rosdep update
sudo -Hu turtle git clone --recurse-submodules -j8 https://github.com/ovgu-FINken/DrivingSwarm /home/turtle/DrivingSwarm
rosdep install --rosdistro melodic --from-paths /home/turtle/DrivingSwarm/src --ignore-src -r -y

#xargs apt install -y  >> /opt/firstrun/apt.log < /opt/firstrun/scripts/20-ros-packages.txt

#rosdep install --from-paths /home/turtle/DrivingSwarm/src --ignore-src -r -y

HOME=/home/turtle/ bash -c "source /opt/ros/melodic/setup.bash && source ~/DrivingSwarm/devel/setup.bash && rosrun robot_upstart install core/launch/turtlebot_bootup.launch"
sudo systemctl daemon-reload && sudo systemctl start core

#sudo -u turtle rosrun turtlebot3_bringup create_udev_rules