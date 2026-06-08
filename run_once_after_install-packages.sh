#!/bin/bash

# Check if Homebrew is installed, install it if missing
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://githubusercontent.com)"

    # Dynamically load brew environment for the rest of this script execution
    if [ -d "/opt/homebrew/bin" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
fi

# Install everything listed in your tracked .Brewfile
if [ -f "$HOME/.Brewfile" ]; then
    echo "Installing packages from Brewfile..."
    brew bundle --global
fi
