export PATH_PREFIX=/usr

# set these in interactive shells
export HISTFILE="$XDG_STATE_HOME/zsh/history"
[ ! -d ${XDG_STATE_HOME}/zsh ] && mkdir -p "$XDG_STATE_HOME/zsh"
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME

setopt nobeep
setopt notify

# antidote
if [[ -f "${PATH_PREFIX}/share/zsh-antidote/antidote.zsh" ]]; then
    source "${PATH_PREFIX}/share/zsh-antidote/antidote.zsh"
elif [[ -f "${ZDOTDIR:-$HOME}/.antidote/antidote.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.antidote/antidote.zsh"
elif [[ -f "${HOME}/git/antidote/antidote.zsh" ]]; then
    source "${HOME}/git/antidote/antidote.zsh"
fi

antidote load

# Completions
export COMPLETION_WAITING_DOTS="true"

FPATH="$PATH_PREFIX/share/${ZDOTDIR}/site-functions:${FPATH}"
autoload -Uz compinit -d ${XDG_STATE_HOME}/zsh/.zcompdump && compinit
autoload bashcompinit && bashcompinit
complete -C "${PATH_PREFIX}/bin/aws_completer" aws
if command -v register-python-argcomplete; then 
    eval "$(register-python-argcomplete pipx)"
fi
complete -o nospace -C $PATH_PREFIX/bin/terraform terraform

for custom in "${ZDOTDIR}"/user/**/*.zsh(N.); do
    source "$custom"
done

if command -v npm > /dev/null; then
    export PATH="$(npm config get prefix)/bin:$PATH"
fi

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

. "$HOME/.local/share/../bin/env"
