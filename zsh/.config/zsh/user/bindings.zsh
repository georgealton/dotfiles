# vim like shell
bindkey -v

for location in "/usr/share/fzf/key-bindings.zsh" "/usr/share/fzf/shell/key-bindings.zsh" "/opt/homebrew/Cellar/fzf/$(fzf --version | cut -d' ' -f1)/shell/key-bindings.zsh"; do
    [[ -f "$location" ]] && source "$location"
done

bindkey -s ^f "${HOME}/.local/bin/tmux-sessionizer\n"
