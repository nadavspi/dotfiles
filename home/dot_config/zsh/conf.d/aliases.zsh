# git
alias g=lazygit
alias gst='git status'
alias gp='git pull && git push'
alias gP='git pull'

alias l=lf
alias ls=eza
alias ll='eza -l'
alias cat=bat
alias lg=lazygit
alias m="neomutt"
alias k=kubectl
alias h=distrobox-host-exec

alias ssh-public-key='op read "op://Personal/ed/public key"'
s() {
  if [[ -n "${TMUX}" ]]; then
    tmux rename-window "$*"
    command kitten ssh "$@"
    tmux set-window-option automatic-rename "on" 1>/dev/null
  else
    command kitten ssh "$@"
  fi
}

alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias k=kubectl

alias sc='sudo -E SYSTEMD_EDITOR=vim systemctl'

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

alias cp-epub="mv -v ~/Downloads/*.epub /mnt/data/watch/books/"

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
