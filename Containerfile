FROM quay.io/toolbx-images/opensuse-toolbox:tumbleweed

# Install packages
COPY boxkit/packages /
RUN grep -v '^#' /packages | xargs zypper --non-interactive install 
RUN rm /packages

WORKDIR /tmp
RUN git clone --depth=1 https://github.com/neovim/neovim && \
    cd neovim && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install && \
    rm -rf /tmp/neovim

# Convience symlinks
RUN ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/just && \ 
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
    ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree
