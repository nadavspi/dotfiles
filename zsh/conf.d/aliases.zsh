# git
alias g=lazygit
alias gst='git status'

alias l=lf
alias ls=eza
alias ll='eza -l'
alias cat=bat
alias lg=lazygit
alias s='kitty +kitten ssh'
# tmux
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'

alias t='task'

# directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# editing
if type nvim > /dev/null 2>&1; then
  alias vim=nvim
fi
alias v=nvim
alias e='emacsclient -c -a emacs'

alias -g L='| bat --style plain'
alias -g F='| fzf --reverse'

alias cp-epub="mv -v ~/Downloads/*.epub /mnt/nfs/data/watch/books/"

alias dup="sudo zypper dup"
