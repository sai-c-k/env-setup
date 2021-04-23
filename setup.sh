#!/bin/bash

set -e


BASH_PROFILE="${HOME}/.bash_profile"
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
DOT_FILES_DIR="${DIR}/dotfiles"
EMAIL="Sai.C.K.Dev@gmail.com"
OH_MY_ZSH_DIR="${HOME}/.oh-my-zsh"
OS="$(uname)"
USERNAME="Sai-C-K"

source "${DIR}/functions.sh"

if [ "$OS" == "Linux" ]; then
    BREW_HOME="/home/linuxbrew"
fi
echo "Starting Environment Setup..."

if  ! command_exists brew; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrew installation complete."
  {
    echo "# Brew config start"
    echo "eval \$(${BREW_HOME}/.linuxbrew/bin/brew shellenv)"
    echo "# Brew config end"
  } >> "${BASH_PROFILE}"
  # shellcheck disable=SC1090
  source "${BASH_PROFILE}"
  brew install -f gcc
fi

if  ! command_exists git; then
  echo "Installing Git..."
  brew install git
  # Configure Git
  cp "${DOT_FILES_DIR}/.gitignore" "${HOME}"
  git config --global user.email "${EMAIL}"
  git config --global user.name "${USERNAME}"
  git config --global core.excludesfile "${HOME}/.gitignore"
  echo "Git Installation Complete."
fi

sudo -v

if  ! command_exists zsh; then
  echo "Installing Z shell..."
  if  [[ "${OS}" == "Linux" ]]; then
     sudo apt install zsh
  else [[  "${OS}" == "Mac" ]]
     brew install -f zsh
  fi
  echo "Z shell installation complete."
fi

if [ ! -d "${OH_MY_ZSH_DIR}" ]; then
  echo "Installing Oh My Zsh..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  cp "${DOT_FILES_DIR}/.aliases" "${HOME}"
  cp "${DOT_FILES_DIR}/.zshrc" "${HOME}"
  echo "Oh My Zsh installation complete."
fi

if  [ ! -d "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"
  cp "${DOT_FILES_DIR}/.p10k.zsh" "${HOME}"
  echo "Powerlevel10k installation complete."
fi

echo "Environment Setup Completed."
