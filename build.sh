#!/bin/bash
set -e

echo "Installing dependencies..."
pip install -e .

echo "Installing BAML CLI..."
pip install baml-py baml-cli

echo "Generating BAML client..."
baml-cli generate

echo "Build complete!"

