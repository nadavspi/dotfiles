FROM debian:latest

ENV TERM=xterm

RUN apt-get update
RUN apt-get install -y git vim make fzf
RUN apt-get autoremove
RUN apt-get clean

RUN mkdir -p /root/.vim
COPY . /root/.vim
RUN cd /root/.vim/; make

WORKDIR /root/src
ENTRYPOINT ["vim", "."]
