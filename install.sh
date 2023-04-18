git clone https://github.com/zsh-users/antigen.git ~/antigen
cd ~/antigen
make
ln -s ~/antigen/bin/antigen.zsh ~/antigen.zsh
mv ~/.zshrc ~/.zshrc_backup
ln -s ~/dotfiles/.shrc ~/.shrc
ln -s ~/dotfiles/.zshrc ~/.zshrc
git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/zsh-git-prompt

# need powerline
git clone https://github.com/gpakosz/.tmux.git
ln -s ~/dotfiles/.tmux.conf.local ~/.tmux.conf.local

ln -s ~/dotfiles/.ycm_extra_conf.py ~
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
mv ~/.emacs.d ~/.emacs.d.backup
ln -s ~/dotfiles/.emacs.d ~
mv ~/.vimrc ~/.vimrc.local    # Backup your own .vimrc and, it will also be executed.
ln -s ~/dotfiles/.vimrc ~
vim +PluginInstall +qall
ln -s ~/dotfiles/.shrc ~
