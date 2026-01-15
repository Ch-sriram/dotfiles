#!/bin/bash

sudo apt update
sudo apt install -y git tmux ripgrep fd-find curl openjdk-17-jdk

PACKAGES_DIR="$HOME/packages"
mkdir -p "$PACKAGES_DIR"

NVIM_LINUX_DIR="nvim-linux-x86_64"
curl -L https://github.com/neovim/neovim/releases/download/nightly/${NVIM_LINUX_DIR}.tar.gz | tar xzf - -C "${PACKAGES_DIR}"

echo "Installing nvim..."
NVIM_BIN_DIR="${PACKAGES_DIR}/${NVIM_LINUX_DIR}/bin"
ln -s ~/usr/local/bin/ "${NVIM_BIN_DIR}/nvim"

