# Setup Instructions
Create a zshrc file that sources the scripts in `xdg/config/zsh/rcs`.
Here's an example with a bare-bones setup for a local osx machine:

```zsh
# Assign XDG CONFIG Values
source ${HOME}/code/xdg/config/zsh/rcs/set_xdg_defaults.zsh

ZSH_RCS=$XDG_CONFIG_HOME/zsh/rcs
source $ZSH_RCS/personalize.zsh
source $ZSH_RCS/vim_keybindings.zsh
source $ZSH_RCS/completion.zsh
source $ZSH_RCS/prompt.zsh
```
