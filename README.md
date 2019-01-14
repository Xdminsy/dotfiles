# How to use

---
```shell
git clone https://github.com/Xdminsy/dotfiles.git
cd dotfiles
chmod +x install.sh
install.sh
```

Then let's install YouCompleteMe Manually.
```shell
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
# You can run ./intall.sh --help for help
./install.py --clang-completer
```