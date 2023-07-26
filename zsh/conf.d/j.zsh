j() {
  local preview_cmd="ls {2..}"
  if command -v exa &> /dev/null; then
      preview_cmd="exa -l {2}"
  fi

  if [[ $# -eq 0 ]]; then
               cd "$(autojump -s | sort -k1gr | awk -F : '$1 ~ /[0-9]/ && $2 ~ /^\s*\// {print $1 $2}' | fzf --height 80% --reverse --inline-info --preview "$preview_cmd" --preview-window down:50% | cut -d$'\t' -f2- | sed 's/^\s*//')"
  else
      cd $(autojump $@)
  fi
}

