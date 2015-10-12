export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
DEFAULT_USER="nadav"
plugins=(git tmux ssh-agent)

export UPDATE_ZSH_DAYS=30
DISABLE_AUTO_TITLE="true"

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"

alias ec="emacsclient -t"
alias v="vim"
alias vi="vim"
alias n="ncmpcpp"

auto-ls () {
  if [[ $#BUFFER -eq 0 ]]; then
    echo ""
    ls
    zle redisplay
  else
    zle .$WIDGET
  fi
}
zle -N accept-line auto-ls
zle -N other-widget auto-ls

# No delay for mode change (vi mode)
export KEYTIMEOUT=1

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities github nspiegelman

if [[ -f ~/.zshrc-local ]]; then
  source ~/.zshrc-local
fi
