# Dotfiles Test Environment

Test your chezmoi configuration in an isolated container before applying changes to your machine.

## Prerequisites

- [Rancher Desktop](https://rancherdesktop.io) with the **dockerd (moby)** container runtime selected
- Docker compatibility layer enabled (on by default in Rancher Desktop)

## Usage

All commands are run from the **repo root**.

### Build

```bash
docker build -f .dev/Dockerfile -t dotfiles-test .
```

### Run

```bash
docker run -it dotfiles-test
```

You'll land in a zsh shell as `testuser` with your dotfiles applied. Verify your aliases, PATH, config files, and installed tools are all present.

### Iterate

```bash
docker build -f .dev/Dockerfile -t dotfiles-test . && docker run -it dotfiles-test
```

## How it works

| Step | What happens |
|------|-------------|
| 1 | Ubuntu 24.04 base with build dependencies |
| 2 | Non-root `testuser` created (Homebrew requires this) |
| 3 | Linuxbrew installed |
| 4 | `chezmoi` installed via brew |
| 5 | Local chezmoi source copied into the container |
| 6 | `chezmoi apply` runs all `run_once_` and `run_onchange_` scripts |
| 7 | Interactive zsh shell for manual verification |

> **Note:** macOS-only casks are excluded automatically via template conditionals — only Linux-compatible packages are installed in the container.
