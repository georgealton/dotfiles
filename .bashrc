bind '"\e[5~": history-search-backward'
bind '"\e[6~": history-search-forward'

export HISTCONTROL=ignoreboth
export EDITOR=vim
export PAGER=less

alias grep='grep --color=auto'
alias ls="ls --color=auto"

shopt -s checkwinsize
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000


PS1="┌──[\t]─[\e[0;33m\u\e[0m on \e[0;34m\h\e[0m]─[\e[2;37m\w\e[0m]\n└─\$ >>>"

eval "$(grunt --completion=bash)"

if [ -f /etc/arch-release ] ; then
	alias upgrade='sudo pacman -Syu'
	alias install='sudo pacman -S'
fi

