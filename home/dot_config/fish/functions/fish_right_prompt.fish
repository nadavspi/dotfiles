function fish_right_prompt
    set -l hostname_color $fish_color_host
    if set -q SSH || set -q SSH_TTY
        set hostname_color $fish_color_host_remote
    end
    echo -n -s (set_color $hostname_color) (prompt_hostname)
end
