#!/bin/bash

# Ensure brew-installed binaries are in PATH
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Homebrew installs the binary as rustup-init on macOS and rustup on Linux
if command -v rustup-init &> /dev/null; then
    rustup-init -y --no-modify-path
elif command -v rustup &> /dev/null; then
    rustup -y --no-modify-path
else
    echo "rustup installer not found. Skipping Rust setup."
    exit 0
fi

# Source cargo env so rustup and rustfmt are available in this script
source "$HOME/.cargo/env"

rustup component add rustfmt clippy
