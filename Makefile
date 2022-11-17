install:
	mkdir -p $(HOME)/.config
	make git
	make nvim
	make $(HOME)/.config/tmux
	make $(HOME)/.config/fish

git:
	make $(HOME)/.gitignore
	make $(HOME)/.gitconfig

$(HOME)/.gitignore:
	ln -s $(shell pwd)/gitignore $(HOME)/.gitignore

$(HOME)/.gitconfig:
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

$(HOME)/.config/alacritty:
	ln -s $(shell pwd)/alacritty $(HOME)/.config/alacritty

$(HOME)/.config/fish:
	ln -s $(shell pwd)/fish $(HOME)/.config/fish

ansible:
	python3 -m pip install --upgrade --user ansible

docker:
	docker build -t 'nadavspi/shell' .

.PHONY: install docker nvim vim-plug nvim-plugins git ansible
