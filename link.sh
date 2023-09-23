#!/bin/bash

CFG="$1"
SCRIPT_DIR="$(readlink -f "$(dirname "$0")")"

case $CFG in
    alacritty)
        src=("$SCRIPT_DIR/alacritty")
        trg=("$HOME/.config/alacritty")
    ;;
    i3)
        src=("$SCRIPT_DIR/i3")
        trg=("$HOME/.config/i3")
    ;;
    ideavim)
        src=("$SCRIPT_DIR/ideavimrc")
        trg=("$HOME/.ideavimrc")
    ;;
    neovim)
        src=("$SCRIPT_DIR/nvim")
        trg=("$HOME/.config/nvim")
    ;;
    picom)
        src=("$SCRIPT_DIR/picom.conf")
        trg=("$HOME/.config/picom.conf")
    ;;
    polybar)
        src=("$SCRIPT_DIR/polybar")
        trg=("$HOME/.config/polybar")
    ;;
    tmux)
        src=("$SCRIPT_DIR/tmux")
        trg=("$HOME/.config/tmux")
    ;;
    zathura)
        src=("$SCRIPT_DIR/zathura")
        trg=("$HOME/.config/zathura")
    ;; 
    zsh)
        src=("$SCRIPT_DIR/zshell/zshrc" "$SCRIPT_DIR/zshell/zsh")
        trg=("$HOME/.zshrc" "$HOME/.config/zsh" )
    ;;
esac

# target=("$SCRIPT_DIR/")
for i in "${!src[@]}"; do
    echo Linking "${src[$i]}" to "${trg[$i]}"
    ln -s "${src[$i]}" "${trg[$i]}"
done
