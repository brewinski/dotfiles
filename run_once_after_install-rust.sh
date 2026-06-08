#!/bin/bash

# Ensure brew-installed binaries are in PATH
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if ! command -v rustup &> /dev/null; then
    echo "rustup not found. Skipping Rust setup."
    exit 0
fi

rustup install stable
rustup default stable
rustup component add rustfmt clippy
