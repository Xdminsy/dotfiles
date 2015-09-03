# How to use

---

## **Use .vimrc**

```shell
git clone https://github.com/Xdminsy/dotfiles.git
cd dotfiles
cp .ycm_extra_conf.py ~
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
mv ~/.vimrc ~/.vimrc.local    # Backup your own .vimrc and, it will also be executed.
cp .vimrc ~    # Use this .vimrc
```

Then fire up vim. Use `:NeoBundleInstall` and, wait :-)<br>Then let's install YouCompleteMe.

```shell
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
# You can run ./intall.sh --help for help
./install.py --clang-completer
```

## **Use .shrc**

```shell
cp .shrc ~
echo "source ~/.shrc" >> ~/.$(basename $SHELL)rc
```

