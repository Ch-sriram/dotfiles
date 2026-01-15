#!/usr/bin/bash

set -e

DOTFILES="$HOME/dotfiles"

link () {
  src="$DOTFILES/$1"
  dest="$2"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Backing up $dest → $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  ln -s "$src" "$dest"
  echo "Linked $src → $dest"
}

mkdir -p ~/.config

link "nvim" "$HOME/.config/nvim"
link "tmux/tmux.conf" "$HOME/.tmux.conf"
link "git/gitconfig" "$HOME/.gitconfig"
link "git/gitconfig.personal" "$HOME/.gitconfig.personal"
link "git/gitconfig.strand" "$HOME/.gitconfig.strand"
link "delta/delta.config" "$HOME/.delta/delta.config"

