# LOCALE
export LC_ALL="en_GB.UTF-8"
export LANG="en_GB.UTF-8"

export EDITOR="nvim"
export VISUAL="$EDITOR"

export BROWSER="flatpak run app.zen_browser.zen"

# XDG DIRS
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

# Starship prompt
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"

# Bat
export BAT_CONFIG_PATH="${XDG_CONFIG_HOME}/bat/bat.conf"
export MANROFFOPT='-c'
export MANPAGER="nvim +Man!"

# NPM
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# AWS
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_SDK_LOAD_CONFIG=1

# Mac
# BREW
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/brew/Brewfile"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CACHE_DIR="${XDG_CACHE_HOME}"/brew
export HOMEBREW_LOGS="${XDG_DATA_HOME}"/brew/logs

export GEM_HOME="${XDG_DATA_HOME}"/gem
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}"/gem
export RBENV_ROOT="${XDG_DATA_HOME}"/rbenv

# Docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}"/docker

#NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/zcompdump/.zcompdump"

# ANTIDOTE
export ADOTDIR="$XDG_DATA_HOME/antidote"

# Python
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
export MYPY_CACHE_DIR="${XDG_CACHE_HOME}/mypy"
export PIP_CACHE_DIR="${XDG_CACHE_HOME}/pip"
export PIPX_HOME="${XDG_DATA_HOME}/pipx"
## python >= 3.13
export PYTHON_HISTORY="${XDG_STATE_HOME}/python/history"

# Go
export GOPATH="${XDG_DATA_HOME}"/go
export GOCACHE="${XDG_CACHE_HOME}"/go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS="--reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --bind='ctrl-/:toggle-preview'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview'"

# Rust
export CARGO_HOME="${XDG_DATA_HOME}"/cargo
[ -f $CARGO_HOME/env ] && . "$CARGO_HOME/env"
[[ -f $CARGO_ENV ]] && source "/home/george/.local/share/cargo/env"
export RUSTUP_HOME="${XDG_DATA_HOME}"/rustup
export PATH="$CARGO_HOME/bin:$PATH"

# Zoxide
export _ZO_DATA_DIR="${XDG_DATA_HOME}"/zoxide

# QT GUI
export QT_QPA_PLATFORM=wayland
export GTK_THEME=Adwaita:dark

## Font
export FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PYENV_ROOT/bin:$PATH"
