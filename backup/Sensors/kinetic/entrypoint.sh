#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/kinetic/setup.bash"

apt update

# Compile ROS packages
cd /root/catkin_ws
# catkin_make

source "/root/catkin_ws/devel/setup.bash"
exec "$@"
