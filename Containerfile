FROM quay.io/toolbx-images/opensuse-toolbox:tumbleweed

# Install packages
COPY packages /
RUN grep -v '^#' /packages | xargs zypper --non-interactive install 
RUN rm /packages
WORKDIR /

# Convience symlinks
RUN ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/just && \ 
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree
