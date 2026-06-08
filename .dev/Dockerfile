FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV NONINTERACTIVE=1

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

# Homebrew forbids running as root
RUN useradd -m -s /bin/zsh testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

CMD ["/bin/zsh", "-l"]
