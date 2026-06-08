FROM ubuntu:24.04

# Prevent interactive prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive
ENV NONINTERACTIVE=1

# 1. Install baseline system dependencies required for Linuxbrew and Chezmoi
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    sudo \
    procps \
    file \
    ca-certificates \
    zsh \
    && rm -rf /var/lib/apt/lists/*

# 2. Homebrew strictly forbids running as root. Create a 'testuser' with sudo privileges.
RUN useradd -m -s /bin/zsh testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

# 3. Install Linuxbrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 4. Force Homebrew binaries into the environment PATH for subsequent commands
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

# 5. Install chezmoi via the freshly installed brew
RUN brew install chezmoi

# 6. Copy your LOCAL chezmoi source directory straight into the container
# This allows you to test your scripts locally BEFORE pushing changes to GitHub!
RUN mkdir -p .local/share/chezmoi
COPY --chown=testuser:testuser . .local/share/chezmoi/

# 7. Execute chezmoi apply to trigger your before/after scripts and config deployment
RUN chezmoi apply --verbose

# Launch an interactive Zsh login shell when starting the container
CMD ["/bin/zsh", "-l"]
