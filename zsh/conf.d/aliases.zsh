# git
alias g=lazygit
alias gst='git status'

alias l=lf
alias ls=eza
alias ll='eza -l'
alias cat=bat
alias lg=lazygit
alias s='TERM=xterm ssh'

alias zl=zellij
alias ta='zellij attach'
alias ts='zellij -s'
alias tl='zellij list-sessions'
function zr () { zellij run --name "$*" -- zsh -ic "$*";}
function zrf () { zellij run --name "$*" --floating -- zsh -ic "$*";}
function ze () { zellij edit "$*";}
function zef () { zellij edit --floating "$*";}

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

function remote-nix-install () {
  if [[ $# -lt 1 ]]
  then
    echo "Usage: remote-nix-install <hostname>"
    return 1
  fi
  command="curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm"
  ssh $1 $command
}

alias ros="rpm-ostree"
