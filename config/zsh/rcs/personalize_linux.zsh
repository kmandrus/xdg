# LINUX-SPECIFIC PERSONALIZATION

if [[ $OSTYPE != linux* ]]; then
    print -u2 "personalize_linux.zsh: not running on Linux ($OSTYPE), skipping."
    return 0
fi


# ALIASES
# GNU ls spells the colorize flag --color=auto (BSD ls uses -G).
alias ls="ls --color=auto"
