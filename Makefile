vim:
	mv -n ~/.vimrc ~/.vimrc.old
	mv -n ~/.vim ~/.vim.old
	ln -s $$PWD/.vimrc ~/
	ln -s $$PWD/.vim ~/
bash:
	ln -s $$PWD/.bash_profile ~/
	ln -s $$PWD/.bash_aliases ~/
	echo 'source ~/.bash_profile;' >> ~/.bashrc
