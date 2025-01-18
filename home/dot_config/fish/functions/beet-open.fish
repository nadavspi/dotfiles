function beet-open
    set -l paths (beet ls -a $argv -f '$path')
    set -l count (count $paths)

     if test $count -eq 0
        echo "None found"
        return 1
    end
    
    if test $count -gt 4
        echo "This will open $count directories. Continue? [y/N]"
        read -l confirm
        if test "$confirm" != "y" -a "$confirm" != "Y"
            echo "Cancelled"
            return 1
        end
    end
    
    printf '%s\n' $paths | sed 's/.*/"&"/' | xargs open
end
