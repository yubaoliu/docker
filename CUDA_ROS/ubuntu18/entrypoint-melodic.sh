#!/bin/bash
set -e

# setup ros environment
echo "source melodic"
source "/opt/ros/melodic/setup.bash"

echo "source catkin_ws"
source "/root/catkin_ws/devel/setup.bash"

exec "$@"
