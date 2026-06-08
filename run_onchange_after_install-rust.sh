#!/bin/bash

# Ensure brew is in PATH
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export HOMEBREW_NO_AUTO_UPDATE=1

# rustup is keg-only on macOS so brew bundle can't install it cleanly.
# Install it here where we can handle the post-install failure and PATH.
brew install rustup 2>&1 || true

# Add keg-only macOS path so rustup is reachable in this script
[[ -d "/opt/homebrew/opt/rustup/bin" ]] && export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

if ! command -v rustup &> /dev/null; then
    echo "rustup not found after install. Skipping Rust setup."
    exit 0
fi

rustup toolchain install stable
rustup default stable

source "$HOME/.cargo/env" 2>/dev/null || true

rustup component add rustfmt clippy
