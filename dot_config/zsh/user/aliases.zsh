alias cat='bat'
alias ls='exa --icons'
alias tree='ls --tree'
alias dig='dog'
alias vim='nvim'

if command -v gmake > /dev/null; then
    alias make='gmake'
fi
alias cd='z'

alias evertzio='dir=$(fd --type d --max-depth 1 . ~/work/evertz-fbrnd | fzf --preview "[[ -f {}README.md ]] && glow -s dark {}README.md || exa -l {}" --preview-window=nohidden); tmux neww -S -c $dir -n $(basename $dir); nvim .'
alias aws-profile='export AWS_PROFILE=$(aws configure list-profiles | fzf --height 30%)'

# macos specific
if [[ $(uname -s) == 'Darwin' ]]; then
    alias firefox='open -a firefox'
fi

function _ss_window() {
    local window_filter='.. | select(.type?) | select(.focused).rect | \(.x),\(.y) \(.width)x\(.height)'
    grim -g $(swaymsg -t get_tree | jq -j $window_filter) $(xdg-user-dir PICTURES)/$(date +%s_grim.png)
}
alias screenshot_window=_ss_window
alias screenshot_fullscreen='grim -o $(swaymsg -t get_outputs | jq -r ".[] | select(.focused) | .name") $(xdg-user-dir PICTURES)/$(date +%s_grim.png)'
