install:
	make $(HOME)/.vim
	make $(HOME)/.vimrc
	make bundle/Vundle.vim
	make PluginInstall

uninstall:
	rm -f $(HOME)/.vimrc

update:
	git pull
	make PluginInstall

$(HOME)/.vim:
	ln -s $(shell pwd) $(HOME)/.vim

$(HOME)/.vimrc:
	ln -s $(shell pwd)/vimrc $(HOME)/.vimrc

bundle/Vundle.vim:
	mkdir -p bundle
	git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle.vim

PluginInstall:
	vim +PluginClean\! +PluginInstall +qall

clean:
	mv -f $(HOME)/.vimrc $(HOME)/.vimrc.backup
	rm -rf $(HOME)/.vim/bundle

docker:
	docker build -t 'nadavsp/vimrc' .

.PHONY: PluginInstall clean install uninstall update docker
