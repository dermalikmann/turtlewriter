#!/usr/bin/env bash

sudo -Hu turtle bash -c "cd /home/turtle/DrivingSwarm && catkin build -p2 -j2"

sudo -Hu turtle bash -c "source /opt/ros/melodic/setup.bash && source ~/DrivingSwarm/devel/setup.bash && rosrun robot_upstart install core/launch/turtlebot_bootup.launch"

sudo systemctl daemon-reload && sudo systemctl start core
