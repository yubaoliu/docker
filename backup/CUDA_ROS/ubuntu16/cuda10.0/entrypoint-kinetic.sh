#!/bin/bash
set -e

# setup ros environment
echo "source kinetic"
source "/opt/ros/kinetic/setup.bash"

echo "source catkin_ws"
source "/root/catkin_ws/devel/setup.bash"

exec "$@"
