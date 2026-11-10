# Setup Instructions
Create a zshrc file that sources the scripts in `xdg/config/zsh/rcs`.

`personalize_all_platforms.zsh` holds configuration that works everywhere.
Platform-specific configuration lives alongside it in a `personalize_<platform>.zsh`
file (e.g. `personalize_osx.zsh`), which should be sourced *last* -- it activates
zsh-syntax-highlighting, which must wrap the widgets and completion config that the
earlier files install.

Here's an example with a bare-bones setup for a local osx machine:

```zsh
# Assign XDG CONFIG Values
source ${HOME}/code/xdg/config/zsh/rcs/set_xdg_defaults.zsh

ZSH_RCS=$XDG_CONFIG_HOME/zsh/rcs
source $ZSH_RCS/personalize_all_platforms.zsh
source $ZSH_RCS/vim_keybindings.zsh
source $ZSH_RCS/completion.zsh
source $ZSH_RCS/prompt.zsh
source $ZSH_RCS/personalize_osx.zsh
```

On Linux, source `personalize_linux.zsh` in place of `personalize_osx.zsh`.

Both `personalize_osx.zsh` and `personalize_linux.zsh`.
