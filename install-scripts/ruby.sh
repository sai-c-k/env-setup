#!/bin/bash

set -e

source <(curl -fsSL https://raw.githubusercontent.com/sai-c-k/env-setup/main/functions.sh)

OS="$(uname)"

if ! command_exists brew; then
  echo "Please install Homebrew."
  exit 1
fi

if ! command_exists rbenv; then
  echo "Installing rbenv..."
  if  [[ "${OS}" == "Linux" ]]; then
      sudo apt install rbenv
  elif [ "${OS}" == "Mac" ]; then
    brew install rbenv
  fi
  echo "Installation Complete: rbenv"
fi

RBENV_PLUGINS="$(rbenv root)"/plugins

if [ ! -d "${RBENV_PLUGINS}" ]; then
  echo "Installing ruby-build..."
  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
  echo "Installation Complete: ruby-build"
fi