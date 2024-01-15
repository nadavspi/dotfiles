FROM ghcr.io/ublue-os/arch-distrobox:latest

RUN ln -fs /bin/sh /usr/bin/sh && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree

# Create build user
RUN useradd -m --shell=/bin/bash build && usermod -L build && \
   echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
   echo "root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install packages
USER build
WORKDIR /home/build
COPY extra-packages /
RUN sudo pacman -Syu && \
    grep -v '^#' /extra-packages | xargs paru -S --noconfirm
USER root
RUN rm /extra-packages
WORKDIR /

# Clean up
RUN userdel -r build && \
    rm -drf /home/build && \
    sed -i '/build ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    sed -i '/root ALL=(ALL) NOPASSWD: ALL/d' /etc/sudoers && \
    rm -rf \
        /tmp/* \
        /var/cache/pacman/pkg/*
