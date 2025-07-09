#!/bin/bash
set -e

echo "Running black..."
black .

echo "Running flake8..."
flake8 .

echo "Running tests..."
pytest

echo "Building Docker image..."
docker build -t availability-tracker .

echo "Launching app with Docker Compose..."
docker-compose up -d --build

