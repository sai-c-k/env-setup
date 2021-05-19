#!/bin/bash

set -e

source <(curl -fsSL https://raw.githubusercontent.com/sai-c-k/env-setup/main/install-scripts/node.sh)

if ! command_exists npm; then
  echo "Please install npm."
  exit 1
fi

if ! command_exists gatsby; then
  echo "Installing Gatsby..."
  npm install --global gatsby-cli
  echo "Installation Complete: Gatsby"
fi