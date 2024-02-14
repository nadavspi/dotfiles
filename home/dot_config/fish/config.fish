if status is-interactive
    set fish_greeting
    fish_config theme choose catppuccin-mocha
    set -g EDITOR nvim

    zoxide init fish | source
end
