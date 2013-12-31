bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'
export HISTCONTROL=ignoredups
PS1="┌──[\t]─[\e[0;33m\u\e[0m on \e[0;34m\h\e[0m]─[\e[2;37m\w\e[0m]\n└─\$ >>>"
