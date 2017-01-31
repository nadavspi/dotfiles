source ~/.zsh/colors.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/git.zsh
[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh

if [[ -f ~/.zshrc-local ]]; then
  source ~/.zshrc-local
fi


