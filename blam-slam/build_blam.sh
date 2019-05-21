#!/bin/bash

mkdir -p ~/data/share
cd ~/data/share

echo "compile blam"
git clone https://github.com/yubaoliu/blam.git
cd blam
./build
