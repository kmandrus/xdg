# custom prompt setup
add_to_fpath $XDG_CONFIG_HOME/zsh/functions/prompt
autoload -Uz set_prompt
setopt PROMPT_SUBST
autoload add-zsh-hook
add-zsh-hook -Uz precmd set_prompt

