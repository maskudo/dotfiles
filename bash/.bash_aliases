# enable color support of ls
if  type dircolors &> /dev/null ; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias nv='nvim'
alias v='vim'
alias lg='lazygit'
alias ld='lazydocker'
alias t='tmux'
alias ta='tmux a'
alias ssh='TERM=xterm ssh'
alias tn="tmux new -s \$(pwd | sed 's/.*\///g')"
alias r="ranger"
alias copy="xclip -selection clipboard"
alias yz="yazi"

if type bat &>/dev/null; then
	alias cat="bat"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'" # prettier manpages
  export MANROFFOPT="-c"
fi
