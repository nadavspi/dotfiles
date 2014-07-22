export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="pygmalion"
DEFAULT_USER="nadav"
plugins=(git tmux ssh-agent)

export UPDATE_ZSH_DAYS=30
DISABLE_AUTO_TITLE="true"

source $ZSH/oh-my-zsh.sh

export PATH="/Users/nadav/.rvm/gems/ruby-2.0.0-p247/bin:/Users/nadav/.rvm/gems/ruby-2.0.0-p247@global/bin:/Users/nadav/.rvm/rubies/ruby-2.0.0-p247/bin:/Users/nadav/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/usr/local/mysql/bin"
export EDITOR="vim"

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

# source ~/.zshrc-local
