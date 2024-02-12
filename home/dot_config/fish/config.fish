if status is-interactive
    set fish_greeting
    fish_config theme choose catppuccin-mocha

    function multicd
        echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
    end
    abbr --add dotdot --regex '^\.\.+$' --function multicd
end
