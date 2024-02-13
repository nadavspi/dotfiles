# https://github.com/small-tech/gills/blob/main/conf.d/gills.fish

# Unless we’re clearing the screen, add a line before the prompt.
function add_empty_line_before_prompt --on-event fish_postexec
    if not string match -r -q 'clear.*' $argv
        printf '\n'
    end
end

# Unless its a command known to not produce output,
# leave an empty space before the command to better
# delinate the command output from the command itself.
function add_empty_line_before_command --on-event fish_preexec
    if not string match -r -q 'cd.*|popd.*|pushd.*' $argv
        printf '\n'
    end
end
