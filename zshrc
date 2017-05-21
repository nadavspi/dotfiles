# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source ~/.zsh/aliases.zsh
source ~/.zsh/exports.zsh

[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh

if [[ -f ~/.zshrc-local ]]; then
  source ~/.zshrc-local
fi

