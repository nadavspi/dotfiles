FROM alpine:latest

ENV SHELL /usr/bin/fish

RUN apk --no-cache add \
    make \
    python3 \
    curl \
    py3-pip \
    neovim \
    fzf \
    the_silver_searcher \
    fish \
    bat \
    git-delta \
    tmux \
    tree \
    git

RUN pip3 install --user --upgrade pynvim
RUN curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > install | fish install --noninteractive

COPY . /root/.dotfiles
RUN cd /root/.dotfiles && make

WORKDIR /mnt/workspace

CMD tmux
