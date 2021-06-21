#!/bin/bash

set -e

source <(curl -fsSL https://raw.githubusercontent.com/sai-c-k/env-setup/install-scripts/python3.sh)

git clone git@github.com:StevenBlack/hosts.git "${CODE_DIR}/hosts"

