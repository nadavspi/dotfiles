if [[ -z "$ZELLIJ" ]]; then
  zellij attach -c main
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# where do you want to store your plugins?
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# get zsh_unplugged and store it with your other plugins
if [[ ! -d $ZPLUGINDIR/zsh_unplugged ]]; then
  git clone --quiet https://github.com/mattmc3/zsh_unplugged $ZPLUGINDIR/zsh_unplugged
fi
source $ZPLUGINDIR/zsh_unplugged/zsh_unplugged.zsh

# make list of the Zsh plugins you use
repos=(
  romkatv/powerlevel10k
  marlonrichert/zsh-autocomplete
  zsh-users/zsh-completions
  zsh-users/zaw
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-autosuggestions
)

# now load your plugins
plugin-load $repos

function src_confd {
  local files=("$1"/*.zsh(.N))
  local f; for f in ${(o)files}; do
    source "$f"
  done
}
() {
  local confdirs=(
    "${ZDOTDIR}/conf.d"
    "${ZDOTDIR}/local.d"
  )
  local dir; for dir in $confdirs; do
    [[ -d $dir ]] || continue
    src_confd $dir
  done
}
fpath+="${ZDOTDIR}/completion.d"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
