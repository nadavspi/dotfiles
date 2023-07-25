typeset -U path
path=(~/.fzf/bin $path)

export EDITOR=nvim
export VISUAL=nvim

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path
