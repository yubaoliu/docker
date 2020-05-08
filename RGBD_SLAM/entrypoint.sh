#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/kinetic/setup.bash"
source "/root/catkin_ws/devel/setup.bash"
exec "$@"
