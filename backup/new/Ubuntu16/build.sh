#!/bin/bash

echo "Build the docker images"

echo "latest version"
docke-compose build

echo "cuda 8"
docke-compose -f docker-compose-cuda8.yaml  build

