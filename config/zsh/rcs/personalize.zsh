# XDG SETUP VERIFICATION
for var in XDG_CONFIG_HOME XDG_DATA_HOME XDG_STATE_HOME; do
    if [[ -z ${(P)var} ]]; then
        print -u2 "personalize.zsh: $var is not set."
        print -u2 "XDG_CONFIG_HOME, XDG_DATA_HOME, and XDG_STATE_HOME must all be"
        print -u2 "set for personalization to complete."
        return 1
    fi
done

# SCRIPT SETUP VERIFICATION
ZSH_CONFIG_DIR=$XDG_CONFIG_HOME/zsh
if [[ ! -d $ZSH_CONFIG_DIR ]]; then
   print -u2 "personalize.zsh: ZSH_CONFIG_DIR ($ZSH_CONFIG_DIR) does not exist."
   print -u2 "Ensure XDG_CONFIG_HOME is set appropriately, and that the zsh"
   print -u2 "directory from this repo is symlinked to \$XDG_CONFIG_HOME/zsh."
   return 1
fi


# LOAD SCRIPTS AND FUNCTIONS
load_scripts() {
    scripts_dir=${1}
    export PATH="$PATH:$scripts_dir"
}

add_to_fpath() {
    local dir="$1"

    for p in $fpath
    do
        if [[ $p == $dir ]]; then 
            local is_dir_in_path=TRUE
            break
        fi 
    done

    if [[ -z $is_dir_in_path ]]; then 
        fpath=( $dir "$fpath[@]" )
    fi
}

load_scripts ${$ZSH_CONFIG_DIR}/scripts
add_to_fpath ${ZSH_CONFIG_DIR}/functions/
autoload -Uz goto


# SETUP FZF ZSH INTEGRATION
source <(fzf --zsh)


# WIDGETS
fzf-run-widget() {
    run_shortcuts=$XDG_CONFIG_HOME/run_shortcuts
    if [[ ! -f $run_shortcuts ]]; then
        echo "declare -A CMDS_BY_NICKNAME" > $run_shortcuts
        echo "CMDS_BY_NICKNAME[hello_world]='echo Hello, World!'" >> $run_shortcuts
    fi
    # load associative array of commands by nickname
    source $XDG_CONFIG_HOME/run_shortcuts

    # present the nicknames to the user for selection
    selected_nickname=$(echo ${(k)CMDS_BY_NICKNAME} | sed 's/ /\n/g' | fzf --height 40% --border)
    selected_cmd=$CMDS_BY_NICKNAME[$selected_nickname]

    # run the command
    zle push-line 
    BUFFER=$selected_cmd
    zle accept-line
}
zle -N fzf-run-widget
bindkey -M vicmd '^h' fzf-run-widget
bindkey -M viins '^h' fzf-run-widget

goto-widget() {
    goto
    zle push-input
    zle accept-line
}
zle -N goto-widget
bindkey -M vicmd '^g' goto-widget
bindkey -M viins '^g' goto-widget

clear-widget() {
    zle push-input
    BUFFER="clear"
    zle accept-line
}
zle -N clear-widget
bindkey -M vicmd '^w' clear-widget
bindkey -M viins '^w' clear-widget

git-change-branch-widget() {
    cb
    zle reset-prompt
}
zle -N git-change-branch-widget 
bindkey -M vicmd '^b' git-change-branch-widget 
bindkey -M viins '^b' git-change-branch-widget

autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

fzf-run-widget() {
    # load associative array of commands by nickname
    source ${XDG_CONFIG_HOME}/run_shortcuts

    # present the nicknames to the user for selection
    selected_nickname=$(echo ${(k)CMDS_BY_NICKNAME} | sed 's/ /\n/g' | fzf --height 40% --border)
    selected_cmd=$CMDS_BY_NICKNAME[$selected_nickname]

    # run the command
    zle push-line 
    BUFFER=$selected_cmd
    zle accept-line
}
zle -N fzf-run-widget
bindkey -M vicmd '^h' fzf-run-widget
bindkey -M viins '^h' fzf-run-widget

# OPTIONS
# Turn off beeps
unsetopt BEEP

# HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000000
setopt INC_APPEND_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_FIND_NO_DUPS


# GIT
alias gs="git status"
alias gb="git branch"
alias ga="git add . && git status"
alias gc="git commit -m"
alias gd="git diff"
alias gitmaster="git fetch --no-tags && git rebase origin/master"
alias gitmain="git fetch --no-tags && git rebase origin/main"
cb() { 
    git checkout $(git branch | fzf ${FZF_OPTIONS} ) 
}
gn() {
    git checkout -b $USER/$1
}


#ALIASES
alias nv="nvim"
alias nvl="nvim -l"
alias grep="grep -i -E --color=auto"
alias ls="ls -G"
alias sed="sed -E"
alias python="python3"
alias caffeinate="caffeinate -isd"

# EDITOR
export EDITOR=nvim
