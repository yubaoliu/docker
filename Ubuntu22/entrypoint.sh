#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/jazzy/setup.bash"
exec "$@"
