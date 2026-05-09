FROM ubuntu:26.04

# Install basic development tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ansible \
    curl \
    libnotify-bin \
    git \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create non-root user if it does not already exist
RUN useradd -m -s /usr/bin/sh user1 \
    && echo "user1 ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user1 \
    && chmod 0440 /etc/sudoers.d/user1

# Ensure the workspace is safe for git
RUN su user1 -c "git config --global --add safe.directory /workspaces/ubuntu-workstation-provision"

USER user1
