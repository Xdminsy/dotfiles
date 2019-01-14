ln .ycm_extra_conf.py ~
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
mv ~/.vimrc ~/.vimrc.local    # Backup your own .vimrc and, it will also be executed.
ln .vimrc ~
vim +PluginInstall +qall
ln .shrc ~
echo "source ~/.shrc" >> ~/.$(basename $SHELL)rc
