FROM ubuntu:26.04

ARG USERNAME=user1
ARG USER_UID=1000
ARG USER_GID=1000

# Install basic development tools
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ansible \
    curl \
    libnotify-bin \
    git \
    sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create non-root user, make sure it doesn't collide with existing one
RUN if getent group ${USER_GID} ; then groupdel $(getent group ${USER_GID} | cut -d: -f1) || true; fi \
    && if getent passwd ${USER_UID} ; then userdel -f $(getent passwd ${USER_UID} | cut -d: -f1) || true; fi \
    && groupadd -g ${USER_GID} ${USERNAME} || true \
    && useradd -l -u ${USER_UID} -g ${USER_GID} -m -s /bin/bash ${USERNAME} \
    && usermod -aG sudo ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# Ensure the workspace is safe for git
RUN su user1 -c "git config --global --add safe.directory /workspaces/ubuntu-workstation-provision"

USER user1
