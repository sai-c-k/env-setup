#!/bin/bash

set -e

bash_profile="${HOME}/.bash_profile"
dir="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
dotfilesDir="${dir}/dotfiles"
email="${EMAIL:=Sai.C.K.Dev@gmail.com}"
ohMyZshDir="${HOME}/.oh-my-zsh"
os="$(uname)"
userName="${USERNAME:=sai-c-k}"

source "${dir}/functions.sh"

if [ -z "$(git config user.email)" ]; then
  echo "Setting git user.email config."
  git config --global user.email "${email}"
fi

if [ -z "$(git config user.name)" ]; then
  echo "Setting git user.name config."
  git config --global user.name "${userName}"
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
  } >> "${bash_profile}"
  # shellcheck disable=SC1090
  source "${bash_profile}"
fi

sudo -v

if  ! command_exists zsh; then
  echo "Installing Z shell..."
  if  [[ "${os}" == "Linux" ]]; then
     sudo apt install zsh
  else [[  "${os}" == "Mac" ]]
     brew install -f zsh
  fi
  echo "Z shell installation complete."
fi

if [ ! -d "${ohMyZshDir}" ]; then
  echo "Installing Oh My Zsh..."
  export RUNZSH="no"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  ln -sf "${dotfilesDir}/.alias" "${HOME}"
  ln -sf "${dotfilesDir}/.zshrc" "${HOME}"
  echo "Setup user's default shell to zsh."
  chsh -s "$(which zsh)"
  echo "Oh My Zsh installation complete."
fi

if [ ! -d "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${HOME}/.oh-my-zsh/custom/themes/powerlevel10k"
  ln -sf "${dotfilesDir}/.p10k.zsh" "${HOME}"
  echo "Powerlevel10k installation complete."
fi

mkdir -p "${HOME}/.tmp"

echo "Environment Setup Completed."
