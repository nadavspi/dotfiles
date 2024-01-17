FROM ghcr.io/ublue-os/arch-distrobox:latest

# Create build user
RUN useradd -m --shell=/bin/bash build && usermod -L build && \
   echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
   echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install packages
COPY packages-pacman /
RUN pacman -Syu && \
    grep -v '^#' /packages-pacman | xargs pacman -S --noconfirm
USER build
WORKDIR /home/build
COPY packages-aur /
RUN grep -v '^#' /packages-aur | xargs paru -S --noconfirm
USER root
RUN rm /packages-aur /packages-pacman
WORKDIR /

# Convience symlinks
RUN ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/just && \ 
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update

# Clean up
RUN userdel -r build && \
    rm -drf /home/build && \
    sed -i '/build ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    sed -i '/root ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    rm -rf \
        /tmp/* \
        /var/cache/pacman/pkg/*
