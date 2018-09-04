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
    mkdir /var/run/sshd && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8


ENV LANG en_US.UTF-8

COPY ["ssh-entrypoint.sh","/usr/local/bin/ssh-entrypoint.sh"]

ENTRYPOINT ["/usr/local/bin/ssh-entrypoint.sh"]

EXPOSE 22 80 443
CMD    ["/usr/sbin/sshd", "-D"]
