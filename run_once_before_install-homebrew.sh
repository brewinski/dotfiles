#!/bin/bash

# On Linux, ensure git is available before Homebrew (which requires it to clone itself)
if [[ "$(uname)" == "Linux" ]] && ! command -v git &>/dev/null; then
    if command -v apt-get &>/dev/null;      then sudo apt-get install -y git
    elif command -v dnf &>/dev/null;        then sudo dnf install -y git
    elif command -v yum &>/dev/null;        then sudo yum install -y git
    elif command -v pacman &>/dev/null;     then sudo pacman -S --noconfirm git
    elif command -v zypper &>/dev/null;     then sudo zypper install -y git
    elif command -v apk &>/dev/null;        then sudo apk add git
    elif command -v xbps-install &>/dev/null; then sudo xbps-install -y git
    else echo "WARNING: could not install git — unknown package manager" && exit 1
    fi
fi

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
