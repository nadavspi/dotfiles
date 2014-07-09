dir=~/dotfiles
olddir=~/dotfiles_old
files="gitconfig gitignore vimrc vim gemrc tmux.conf tmuxinator"

echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

echo "Changing to the $dir directory"
cd $dir
echo "...done"

for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir"
  mv ~/.$file ~/dotfiles_old
  echo "Creating symlink to $file in home directory"
  ln -s $dir/$file ~/.$file
done

install_shell_profile () {
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    echo "Zsh is installed. Creating symlink to zshrc"
    ln -s $dir/zshrc ~/.zshrc
  else
    echo "Zsh is not installed. Creating symlink to bashrc"
    ln -s $dir/bashrc ~/.bashrc
  fi
}

install_shell_profile

install_vundle () {
  if [ ! -d ~/dotfiles/vim/bundle ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/dotfiles/vim/bundle/Vundle.vim
  fi
}

install_vundle
