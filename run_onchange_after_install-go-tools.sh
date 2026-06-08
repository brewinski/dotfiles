#!/bin/bash

# Ensure 'go' is installed before running
if ! command -v go &> /dev/null; then
    echo "Go is not installed. Skipping Go tools installation."
    exit 0
fi

echo "⚡ Chezmoi: Checking/Installing Go tools for Neovim..."

# List of Go tools required by Neovim setup
tools=(
    "mvdan.cc/gofumpt@latest"
    "github.com/fatih/gomodifytags@latest"
    "github.com/josharian/impl@latest"
    "github.com/cweill/gotests/gotests@latest"
    "golang.org/x/tools/cmd/callgraph@latest"
    "golang.org/x/vuln/cmd/govulncheck@latest"
    "github.com/rakyll/gotestsum@latest"
    "github.com/koron/gomvp@latest"
    "github.com/stevenmatthewt/godoc-static@latest"
    "github.com/abice/go-enum@latest"
    "github.com/onsi/ginkgo/v2/ginkgo@latest"
)

for tool in "${tools[@]}"; do
    # Extract the binary name from the path (e.g., mvdan.cc/gofumpt -> gofumpt)
    binary=$(basename "$tool" | cut -d'@' -f1)
    
    if ! command -v "$binary" &> /dev/null; then
        echo "Installing $tool..."
        go install "$tool"
    else
        echo "  $binary is already installed."
    fi
done

# Special case: golangci-lint (better handled via its official binary installer or brew)
if ! command -v golangci-lint &> /dev/null; then
    echo "Installing golangci-lint..."
    curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin v1.61.0
fi
