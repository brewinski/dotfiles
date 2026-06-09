#!/bin/bash

# On Linux, install Homebrew prerequisites (git + build tools) before bootstrapping
if [[ "$(uname)" == "Linux" ]]; then
    SUDO=""
    [[ $EUID -ne 0 ]] && SUDO="sudo"

    if command -v apt-get &>/dev/null; then
        $SUDO apt-get update -y
        $SUDO apt-get install -y git build-essential procps curl file ca-certificates
    elif command -v dnf &>/dev/null; then
        $SUDO dnf install -y git gcc gcc-c++ make curl file procps ca-certificates
    elif command -v yum &>/dev/null; then
        $SUDO yum install -y git gcc gcc-c++ make curl file procps ca-certificates
    elif command -v pacman &>/dev/null; then
        $SUDO pacman -S --noconfirm git base-devel curl file procps-ng ca-certificates
    elif command -v zypper &>/dev/null; then
        $SUDO zypper install -y git gcc gcc-c++ make curl file procps ca-certificates
    elif command -v apk &>/dev/null; then
        $SUDO apk add git build-base curl file procps ca-certificates
    elif command -v xbps-install &>/dev/null; then
        $SUDO xbps-install -y git base-devel curl file procps ca-certificates
    else
        echo "WARNING: unknown package manager — skipping prerequisite install" && exit 1
    fi
fi

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
