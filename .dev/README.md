# Dotfiles Test Environment

Simulate a fresh machine setup to verify your chezmoi configuration end-to-end.

## Prerequisites

- [Rancher Desktop](https://rancherdesktop.io) with the **dockerd (moby)** container runtime selected

## Usage

### Build

From the repo root:

```bash
docker build -f .dev/Dockerfile -t dotfiles-test .
```

### Run

```bash
docker run -it dotfiles-test
```

### Bootstrap inside the container

Once inside, run the standard chezmoi one-liner to simulate a fresh device setup:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/brewinski/dotfiles.git && source .zshrc
```

This will:
1. Install chezmoi
2. Clone your dotfiles repo
3. Run `chezmoi apply` — triggering all `run_once_` and `run_onchange_` scripts

Once complete, source your shell config to pick up PATH changes (brew, etc.):

```bash
source ~/.zshrc
```

> On a real machine you'd just open a new terminal — sourcing is only needed here
> because the shell was already running when chezmoi wrote `.zshrc`.
>
> You will be prompted for your personal details (names, emails, SSH signing key)
> on first run. Have these ready before bootstrapping.

## What the container provides

A minimal Ubuntu 24.04 environment with only the system-level dependencies
required to bootstrap Homebrew and chezmoi — nothing else is pre-installed.
This matches the real-world state of a new machine as closely as possible.
