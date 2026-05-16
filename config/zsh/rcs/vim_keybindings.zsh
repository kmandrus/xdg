# VIM KEYBINDINGS
bindkey -v
export KEYTIMEOUT=1

# put and yank using the system clipboard
vi-yank-pbcopy() {
    zle vi-yank
    echo "$CUTBUFFER" | pbcopy
}
vi-delete-pbcopy() {
    zle vi-delete
    echo "$CUTBUFFER" | pbcopy
}
vi-put-after-pbpaste() {
    CUTBUFFER=$(pbpaste)
    zle vi-put-after
}
zle -N vi-yank-pbcopy
zle -N vi-delete-pbcopy
zle -N vi-put-after-pbpaste
bindkey -M vicmd 'y' vi-yank-pbcopy
bindkey -M vicmd 'd' vi-delete-pbcopy
bindkey -M vicmd 'p' vi-put-after-pbpaste

# use hjkl to navigate menu selection
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
