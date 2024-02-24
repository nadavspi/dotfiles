if status is-interactive
and not set -q TMUX
    exec tmux new -A -s main
end

if status is-interactive
    set fish_greeting
    fish_config theme choose catppuccin-mocha
    set -g EDITOR nvim

    zoxide init fish | source
end
