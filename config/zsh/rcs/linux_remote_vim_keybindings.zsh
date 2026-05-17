if [[ ! -d $XDG_CONFIG_HOME/zsh ]]; then
   print -u2 "linux_remote_vim_keybindings.zsh: $XDG_CONFIG_HOME/zsh does not exist."
   print -u2 "Ensure XDG_CONFIG_HOME is set appropriately, and that the zsh"
   print -u2 "directory from this repo is symlinked to \$XDG_CONFIG_HOME/zsh."
   return 1
fi

# VIM KEYBINDINGS FOR REMOTE LINUX
# uses xclip instead of pbcopy/pbpaste for clipboard integration
# put and yank using the system clipboard
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
source $XDG_CONFIG_HOME/zsh/rcs/vim_keybindings.zsh
