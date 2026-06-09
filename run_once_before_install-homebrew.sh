#!/bin/bash

# On Linux, install Homebrew prerequisites (git + build tools) before bootstrapping
if [[ "$(uname)" == "Linux" ]]; then
    if command -v apt-get &>/dev/null; then
        sudo apt-get update -y
        sudo apt-get install -y git build-essential procps curl file ca-certificates
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y git gcc gcc-c++ make curl file procps ca-certificates
    elif command -v yum &>/dev/null; then
        sudo yum install -y git gcc gcc-c++ make curl file procps ca-certificates
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm git base-devel curl file procps-ng ca-certificates
    elif command -v zypper &>/dev/null; then
        sudo zypper install -y git gcc gcc-c++ make curl file procps ca-certificates
    elif command -v apk &>/dev/null; then
        sudo apk add git build-base curl file procps ca-certificates
    elif command -v xbps-install &>/dev/null; then
        sudo xbps-install -y git base-devel curl file procps ca-certificates
    else
        echo "WARNING: unknown package manager — skipping prerequisite install" && exit 1
    fi
fi

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
