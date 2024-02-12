function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)

    set -l color_cwd $fish_color_cwd
    set -l suffix '❯'

    # root gets different cwd color and suffix
    if functions -q fish_is_root_user; and fish_is_root_user
        set suffix '#'
    end

    set -l suffix_color (set_color $fish_color_suffix)
    if test $last_status -ne 0
        set suffix_color (set_color $fish_color_error)
    end

    string join '' -- (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal $prompt_status " " $suffix_color $suffix " "
end
