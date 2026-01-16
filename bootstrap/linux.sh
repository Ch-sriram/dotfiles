#!/bin/bash

sudo apt update

echo "Installing... git, xclip, tmux, ripgrep, fd-find, curl, openjdk-17-jdk"
sudo apt install -y git xclip tmux ripgrep fd-find curl openjdk-17-jdk
echo "Completed Installation"

PACKAGES_DIR="$HOME/packages"
mkdir -p "$PACKAGES_DIR"

ARCH="$(arch)"
NVIM_LINUX_DIR="nvim-linux-${ARCH}"
curl -L https://github.com/neovim/neovim/releases/download/nightly/${NVIM_LINUX_DIR}.tar.gz | tar xzf - -C "${PACKAGES_DIR}"

NVIM_BIN="${PACKAGES_DIR}/${NVIM_LINUX_DIR}/bin"

echo "Linking nvim from ${NVIM_BIN} to ~/local/bin/nvim"
ln -s "${NVIM_BIN}/nvim" "${HOME}.local/bin/nvim"

echo "Linking fdfind from $(which fdfind) to ~/.local/bin/fd"
ln -s "$(which fdfind)" "${HOME}/.local/bin/fd"

