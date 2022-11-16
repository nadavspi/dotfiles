install:
	mkdir -p $(HOME)/.config
	make git
	make nvim
	make $(HOME)/.config/tmux

git:
	ln -s $(shell pwd)/gitignore $(HOME)/.gitignore
	ln -s $(shell pwd)/gitconfig $(HOME)/.gitconfig
	
nvim:
	make vim-plug
	make $(HOME)/.config/nvim
	make nvim-plugins

vim-plug:
	sh -c 'curl -fLo "$(HOME)/.local/share"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

$(HOME)/.config/nvim:
	ln -s $(shell pwd)/nvim $(HOME)/.config/nvim

nvim-plugins:
	nvim +PlugClean\! +PlugInstall\! +qall

$(HOME)/.config/tmux:
	ln -s $(shell pwd)/tmux $(HOME)/.config/tmux

docker:
	docker build -t 'nadavspi/shell' .

.PHONY: install docker nvim vim-plug nvim-plugins git
