#!/bin/bash

set -e

echo "Creating virtual environment..."
uv venv

echo "Activating virtual environment..."
# Detect OS and use correct activation script path
if [ -f ".venv/Scripts/activate" ]; then
    # Windows (Git Bash)
    source .venv/Scripts/activate
elif [ -f ".venv/bin/activate" ]; then
    # Linux/Mac
    source .venv/bin/activate
else
    echo "Warning: Could not find virtual environment activation script"
fi

echo "Setting up dependencies..."
uv sync

echo "Starting Neo4j..."
docker-compose up -d

echo "Generating BAML client..."
baml-cli generate

echo "Starting the app..."
uv run python app.py