#!/bin/bash

set -e

source <(curl -fsSL https://raw.githubusercontent.com/sai-c-k/env-setup/main/functions.sh)

if ! command_exists brew; then
  echo "Please install Homebrew."
  exit 1
fi

if ! command_exists python3; then
  echo "Installing python3..."
  brew install python3
  echo "Installation Complete: python3"
fi