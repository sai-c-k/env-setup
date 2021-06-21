export OS="$(uname)"
export CODE_DIR="${HOME}/code"
export TMP_DIR="${HOME}/.tmp"

mkdir -p "${CODE_DIR}"

source <(curl -fsSL https://raw.githubusercontent.com/sai-c-k/env-setup/main/functions.sh)

# Brew
if [[ "${OS}" == "Linux" ]]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
# Brew End

# ZSH
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${ZSH}/custom"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  # shellcheck disable=SC1090
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH Customs
POWERLINE_FONT_DIR="${ZSH_CUSTOM}/fonts/powerline"
if [ ! -d "${POWERLINE_FONT_DIR}" ]; then
  echo "Installing Powerline Fonts..."
  git clone https://github.com/powerline/fonts.git --depth=1 "${POWERLINE_FONT_DIR}"
  "${POWERLINE_FONT_DIR}/install.sh"
  echo "Powerline Fonts installation complete."
fi

AUTOSUGGESTION_DIR="${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
if [ ! -d "${AUTOSUGGESTION_DIR}" ]; then
  echo "Installing Auto Suggestion Plugin..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "${AUTOSUGGESTION_DIR}"
  echo "Auto Suggestion installation complete."
fi

SYNTAX_HIGHLIGHTING_DIR="${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
if [ ! -d "${SYNTAX_HIGHLIGHTING_DIR}" ]; then
  echo "Installing Syntax Highlighting Plugin..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "${SYNTAX_HIGHLIGHTING_DIR}"
  echo "Syntax Highlighting installation complete."
fi

export ZSH_THEME="powerlevel10k/powerlevel10k"

export plugins=(
  dotenv
  git
  osx
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "${ZSH}/oh-my-zsh.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f "${HOME}/.p10k.zsh" ]] || source "${HOME}/.p10k.zsh"

# ZSH End

# Custom aliases
ALIAS="${HOME}/.alias"
if [ -f "${ALIAS}" ]; then
  # shellcheck source=.alias
  source "${ALIAS}"
fi

if command_exists rbenv; then
  eval "$(rbenv init -)"
fi

