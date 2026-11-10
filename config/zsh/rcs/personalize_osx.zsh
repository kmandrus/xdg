# OSX-SPECIFIC PERSONALIZATION

# Source this AFTER personalize_all_platforms.zsh and completion.zsh:
# zsh-syntax-highlighting must be loaded last so that it can wrap the widgets
# and completion setup those files install.

if [[ $OSTYPE != darwin* ]]; then
    print -u2 "personalize_osx.zsh: not running on OSX ($OSTYPE), skipping."
    return 0
fi


# ALIASES
# BSD ls spells the colorize flag -G (GNU ls uses -G to hide the group column).
alias ls="ls -G"
# caffeinate is an OSX binary; -isd keeps the system awake while it runs.
alias caffeinate="caffeinate -isd"


# ZSH-SYNTAX-HIGHLIGHTING
# Installed via Homebrew: brew install zsh-syntax-highlighting
ZSH_SYNTAX_HIGHLIGHTING=/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -f $ZSH_SYNTAX_HIGHLIGHTING ]]; then
    source $ZSH_SYNTAX_HIGHLIGHTING
else
    print -u2 "personalize_osx.zsh: zsh-syntax-highlighting not found at"
    print -u2 "$ZSH_SYNTAX_HIGHLIGHTING"
    print -u2 "Install it with: brew install zsh-syntax-highlighting"
    print -u2 "(On Apple Silicon brew installs under /opt/homebrew instead.)"
fi
