#!/bin/bash

# Ensure brew-installed binaries are in PATH
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if ! command -v rustup-init &> /dev/null; then
    echo "rustup-init not found. Skipping Rust setup."
    exit 0
fi

rustup-init -y --no-modify-path

# Source cargo env so rustup and rustfmt are available in this script
source "$HOME/.cargo/env"

rustup component add rustfmt clippy
