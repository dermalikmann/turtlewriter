#!/bin/bash
TURTLE_USER=turtle@$TURTLE
FILE_DIR=~/turtlefiles


rm -rf ~/.ssh/known_hosts
ssh-copy-id $TURTLE_USER
sed -i "s/export ROS_HOSTNAME=.*/export ROS_HOSTNAME=$TURTLE/g" $FILE_DIR/bashrc
scp $FILE_DIR/bashrc $TURTLE_USER:~/.bashrc
#scp $FILE_DIR/id_rsa $TURTLE_USER:~/.ssh
#scp $FILE_DIR/id_rsa.pub $TURTLE_USER:~/.ssh
scp $FILE_DIR/firstrun.sh $TURTLE_USER:~/DrivingSwarm/firstrun.sh

ssh $TURTLE_USER

