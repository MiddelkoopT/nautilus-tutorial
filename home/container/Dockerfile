FROM debian:11

## Basic install/update
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --yes apt-utils && \
    apt-get update && apt-get dist-upgrade --yes && \
    apt-get clean

## Pod setup
RUN install --mode=666 /dev/null /var/log/container.log

## Development
RUN apt-get install --yes git python3 ca-certificates build-essential procps curl unzip jq && \
    apt-get install --yes python3-pip gfortran automake && \
    apt-get clean

## Home envrionment
RUN apt-get install --yes sudo dialog && \
    apt-get install --yes bash-completion less vim iproute2 iputils-ping host whois && \
    apt-get clean

## Create user
ARG USER=user
ENV USER=$USER
RUN adduser --disabled-password --gecos $USER $USER && \
    usermod -a -G sudo $USER && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/10-sudo-nopasswd
USER $USER
WORKDIR /home/$USER

## Setup user
RUN install -dv -m 700 ~/projects ~/tmp && \
    install -dpv ~/.local/share/R && echo "R_LIBS_USER=~/.local/share/R" > ~/.Renviron && \
    echo "PERL_HOMEDIR=0" > ~/.perl-homedir && \
    echo "shopt -s globstar dotglob extglob" >> ~/.bashrc && \
    echo "export LESS=-icMR" >> ~/.bashrc && \
    for I in 'color.ui auto' 'push.default simple' 'pull.ff only' 'init.defaultBranch main' ; do git config --global $I ; done
