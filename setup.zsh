# Setup xdg configs on a new machine
# Uses XDG base directory specification

# if XDG_CONFIG_HOME is not set, use the default in the xdg specification
if ! (( ${+XDG_CONFIG_HOME} )); then
    XDG_CONFIG_HOME="$HOME/.config"
fi

# symlink nvim config in this directory to $XDG_CONFIG_HOME/nvim
ln -s config/nvim $XDG_CONFIG_HOME/nvim

