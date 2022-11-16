FROM alpine:latest

ENV SHELL /usr/bin/fish

RUN apk --no-cache add \
    make \
    python3 \
    curl \
    py3-pip \
    neovim \
    fzf \
    fish \
    tmux \
    git

RUN pip3 install --user --upgrade pynvim

COPY . /root/.dotfiles
RUN cd /root/.dotfiles && make

WORKDIR /mnt/workspace

CMD tmux
                            
