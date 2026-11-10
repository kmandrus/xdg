# Install Packages
brew install iterm2
# symlink iterm2 settings
ln -s $XDG_CONFIG_HOME/iterm2_settings $HOME/Library/Preferences/com.googlecode.iterm2.plist 
brew install fzf
brew install fd
brew install ripgrep # required by telescope's live_grep/grep_string
ln -s $(which fdfind) ~/.local/bin/fd # add symlink for fd
brew install neovim
brew install zsh-syntax-highlighting
brew install spaceship
brew install ipython
brew install tree-sitter
brew install tree-sitter-cli
brew install csvtomd
pip install csvkit
pip install black
pip install sqlfluff # sql formatter/linter driven by conform.nvim + nvim-lint
pip install flake8   # python linter driven by nvim-lint

# fonts
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
