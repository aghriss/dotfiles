#!/bin/bash

dot=$1
SCRIPT_DIR=$(readlink -f "$(dirname "$0")")

prepare(){
 local src="$1"
}

case $dot in
    neovim)
        src="nvim"
        ;;
esac

target=$SCRIPT_DIR/



