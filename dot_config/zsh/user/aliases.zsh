alias cat='bat'
alias ls='exa --icons'
alias tree='ls --tree'
alias dig='dog'
alias vim='nvim'
alias make='gmake'
alias cd='z'

alias evertzio='dir=$(fd --type d --max-depth 1 . ~/work/evertz-fbrnd | fzf --preview "[[ -f {}README.md ]] && glow -s dark {}README.md || exa -l {}" --preview-window=nohidden); tmux neww -S -c $dir -n $(basename $dir); nvim .'
alias aws-profile='export AWS_PROFILE=$(aws configure list-profiles | fzf --height 30%)'

# macos specific
if [[ $(uname -s) == 'Darwin' ]]; then
    alias firefox='open -a firefox'
fi
