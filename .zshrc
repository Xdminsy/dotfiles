# ZSH_THEME="robbyrussell"
# plugins=(git z ls tmux cp zsh-autosuggestions zsh-syntax-highlighting)
# source $ZSH/oh-my-zsh.sh

source ~/antigen.zsh

antigen use oh-my-zsh

alias ab="antigen bundle"

ab git
ab pip
ab z
ab tmux
ab ls
ab command-not-found
ab zsh-users/zsh-syntax-highlighting
ab zsh-users/zsh-autosuggestions
ab zsh-users/zsh-history-substring-search
# ab Valiev/almostontop

antigen theme robbyrussell

antigen apply

setopt nobgnice
# source /etc/zsh_command_not_found
source ~/.zsh-git-prompt/zshrc.sh
source ~/.shrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(thefuck --alias)
