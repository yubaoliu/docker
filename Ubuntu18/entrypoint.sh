#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/melodic/setup.sh"
exec "$@"
