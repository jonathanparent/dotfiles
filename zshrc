#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/cyberangel/.sdkman"
[[ -s "/home/cyberangel/.sdkman/bin/sdkman-init.sh" ]] && source "/home/cyberangel/.sdkman/bin/sdkman-init.sh"



# add alias
alias geeknote="python ~/geeknote/geeknote/geeknote.py"
alias browser-sync-start="browser-sync start --server --files \"**/*\""
alias xm="xmodmap ~/.Xmodmap"

# add some emacs aliases
alias ekill="emacsclient -e '(kill-emacs)'"
alias e='emacsclient -n'



# export android sdk path
export PATH=${PATH}:~/Android/Sdk/tools:~/Android/Sdk/platform-tools

# add genymotion path
PATH="$PATH":~/android-dev/genymotion

# add emacs-python path
PATH="$PATH":~/.local/bin

# add composer path
PATH="$PATH":~/.composer/vender/bin



# Setup pyenv environment
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"



# Setup pyenv-virtualenv enviroment
eval "$(pyenv virtualenv-init -)"



# disable virtualenv prompt 
export PYENV_VIRTUALENV_DISABLE_PROMPT=1



# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi



# Run one instance of devilspie to manage window sizes (Linux only)
if [[ "$OSTYPE" =~ "linux-gnu" ]]; then
  if [ ! `pidof devilspie` ]; then
    (devilspie &)
  fi
fi



# Change Keybindings
# if [ -s ~/.Xmodmap ]; then
#     xmodmap ~/.Xmodmap
# fi
