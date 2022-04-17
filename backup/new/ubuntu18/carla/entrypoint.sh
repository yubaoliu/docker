#!/bin/bash
set -e

cd /carla
./ImportAssets.sh

# change the carla version
python3 -m easy_install --user --no-deps PythonAPI/carla/dist/carla-0.9.10-py3.7-linux-x86_64.egg

exec "$@"
