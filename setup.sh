#!/bin/bash

set -e

BASH_PROFILE="${HOME}/.bash_profile"
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
DOT_FILES_DIR="${DIR}/dotfiles"
EMAIL="Sai.C.K.Dev@gmail.com"
OH_MY_ZSH_DIR="${HOME}/.oh-my-zsh"
OS="$(uname)"
USERNAME="sai-c-k"

source "${DIR}/functions.sh"

if [ -z "$(git config user.email)" ]; then
  echo "Setting git user.email config."
  git config --global user.email "${EMAIL}"
fi

if [ -z "$(git config user.name)" ]; then
  echo "Setting git user.name config."
  git config --global user.name "${USERNAME}"
fi

echo "Starting Environment Setup..."

if  ! command_exists brew; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrew installation complete."
  {
    echo "# Brew config start"
    echo "eval \$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo "# Brew config end"
  } >> "${BASH_PROFILE}"
  # shellcheck disable=SC1090
  source "${BASH_PROFILE}"
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
  export RUNZSH="no"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  ln -sf "${DOT_FILES_DIR}/.alias" "${HOME}"
  ln -sf "${DOT_FILES_DIR}/.zshrc" "${HOME}"
  echo "Setup user's default shell to zsh."
  chsh -s "$(which zsh)"
  echo "Oh My Zsh installation complete."
fi

if [ ! -d "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"
  ln -sf "${DOT_FILES_DIR}/.p10k.zsh" "${HOME}"
  echo "Powerlevel10k installation complete."
fi

echo "Environment Setup Completed."
