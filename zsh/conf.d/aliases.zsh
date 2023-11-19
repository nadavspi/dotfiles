# git
alias g=lazygit
alias gst='git status'

alias l=lf
alias ls=eza
alias ll='eza -l'
alias cat=bat
alias lg=lazygit
alias s='kitty +kitten ssh'

alias zl=zellij
alias ta='zellij attach'
alias ts='zellij -s'
alias tl='zellij list-sessions'

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
