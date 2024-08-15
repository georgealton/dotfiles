# vim like shell
bindkey -v
source /usr/share/fzf/key-bindings.zsh
command -v brew && source /opt/homebrew/Cellar/fzf/$(fzf --version | cut -d' ' -f1)/shell/key-bindings.zsh
