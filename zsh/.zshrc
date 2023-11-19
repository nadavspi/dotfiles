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

eval "$(starship init zsh)"
