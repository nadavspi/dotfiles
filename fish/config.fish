
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /Users/nadav/opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

set fish_greeting

set -x EDITOR nvim
abbr -a -- zyp 'sudo zypper'
starship init fish | source

