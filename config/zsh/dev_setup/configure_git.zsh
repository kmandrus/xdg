# Git aliases for first time setup on a new machine
git config --global alias.cb '!git checkout $(git branch | fzf --height 40% --border)'
git config --global alias.last 'log -1 HEAD'
git config --global alias.unstage 'reset HEAD --'
git config --global alias.list 'log --oneline'
git config --global alias.whoops 'commit --amend --no-edit'
git config --global alias.graph 'log --oneline --graph'

# Other git configuration
git config --global init.defaultBranch main
