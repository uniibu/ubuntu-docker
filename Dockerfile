FROM ubuntu:16.04

RUN apt-get update && \
    apt-get -y install \
    locales \
    rsync \
    openssh-server \
    sudo \
    wget \
    unzip \
    ca-certificates \
    curl \
    git \
    build-essential \
    vim \
    nano \
    software-properties-common \
    python-software-properties \
    bash-completion && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8


ENV LANG en_US.UTF-8
EXPOSE 22 80 443
