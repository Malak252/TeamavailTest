#!/bin/bash
set -e

echo "installing dependencies"
npm install

echo "building docker image"
docker build -t coolestv .

echo "launching app with docker Compose"
docker-compose up -d --build

