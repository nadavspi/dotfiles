function ga
  git ls-files -m -o --exclude-standard | \
    fzf -m --print0 --reverse \
    --preview-window "down,70%" \
    --preview 'git diff --color=always {} | delta --file-style omit --no-gitconfig' | \
    xargs -0 -o -t git add
end
