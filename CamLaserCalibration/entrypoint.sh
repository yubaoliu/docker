#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/melodic/setup.sh"

cd ~/catkin_ws && catkin_make

exec "$@"
