#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/noetic/setup.sh"

exec "$@"
