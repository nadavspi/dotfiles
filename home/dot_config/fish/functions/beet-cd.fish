function beet-cd
    set -l paths (beet ls -a $argv -f '$path')
    set -l count (count $paths)
    
    if test $count -eq 0
        echo "None found"
        return 1
    end
    
    if test $count -eq 1
        cd $paths[1]
    else
        set -l selected (printf '%s\n' $paths | fzf)
        if test -n "$selected"
            cd $selected
        end
    end
end
