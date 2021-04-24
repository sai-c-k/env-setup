# Environment Setup

## Goal
- Ideally, create a uniform dev env on all OS's.
- Fast setup of a new OS for dev.
- Personalized dev env:
    - [Z shell](http://zsh.sourceforge.net/) + [oh-my-zsh](https://ohmyz.sh/) with theme [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
    - Custom aliases + functions
    
## Setup

### Prerequisite

- Bash shell available on OS.
- Git installed.

### Windows 10 WSL Additional Instructions.
1. [Install Ubuntu on Windows 10](https://ubuntu.com/tutorials/ubuntu-on-windows)
2. [Install GCC on Ubuntu 20.04](https://linuxize.com/post/how-to-install-gcc-on-ubuntu-20-04/)

### Run
1. [Github SSH-Key Setup](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) 
2. `git clone git@github.com:sai-c-k/env-setup.git ~/code/env-setup`
3. In bash, run `~/code/env-setup/setup.sh`
4. Ensure to follow [Powerlevel10k font installation](https://github.com/romkatv/powerlevel10k#manual-font-installation) for terminal and IntelliJ
