#!/bin/bash

set -e

source <(curl -fsSL https://raw.githubusercontent.com/sai-c-k/env-setup/main/functions.sh)

if ! command_exists brew; then
  echo "Please install Homebrew."
  exit 1
fi

if ! command_exists node; then
  echo "Installing node..."
  brew install node
  echo "Installation Complete: node"
fi