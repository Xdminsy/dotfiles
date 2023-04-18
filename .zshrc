# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH_THEME="robbyrussell"
# plugins=(git z ls tmux cp zsh-autosuggestions zsh-syntax-highlighting)
# source $ZSH/oh-my-zsh.sh

source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle z
# antigen bundle tmux
antigen bundle ls
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle command-not-found # arch need pkgfile
# ab Valiev/almostontop

# antigen theme robbyrussell
antigen theme romkatv/powerlevel10k

antigen apply
unsetopt beep notify bgnice
source ~/zsh-git-prompt/zshrc.sh
source ~/.shrc

## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh    # if manually clone from git
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

eval $(thefuck --alias)

# history
export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

setopt INC_APPEND_HISTORY # inst add history instead when quit
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY # add timestamp to history
setopt HIST_FIND_NO_DUPS # not show duplicated command when search
# setopt HIST_IGNORE_ALL_DUPS # not write duplicated command to histfile

# fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
