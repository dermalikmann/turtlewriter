#!/bin/bash
sudo echo "sudo permissions unlocked"
sudo hostnamectl set-hostname $ROS_HOSTNAME
echo "rewriting origin to use ssh"
git remote remove origin
git add origin git@github.com:ovgu-FINken/DrivingSwarm.git
git checkout uncertainty_grid
gitman install --force
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -r -y
source ~/.bashrc
catkin build -p$(distcc -j) -j$(distcc -j)
