#!/bin/bash

# gcloud-cli cask requires virtualenv but doesn't declare it as a dependency.
# We install it via pip so it's on PATH when the cask's post-install script runs.

command -v gcloud &>/dev/null && exit 0

eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /home/linuxbrew/.linuxbrew/bin/brew shellenv)"

pip3 install --quiet virtualenv
brew install --cask gcloud-cli
