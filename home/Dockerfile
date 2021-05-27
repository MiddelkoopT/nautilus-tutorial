FROM debian:10
LABEL maintainer="tmiddelkoop@internet2.edu"

## Basic install/update 
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    apt-get clean

## Development
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git python3 ca-certificates build-essential procps wget curl unzip jq && \
    apt-get clean

## Interactive
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends emacs-nox && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y aspell-en bash-completion rsync && \
    apt-get clean

## User
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y sudo s3fs python3-pip gfortran automake && \
    apt-get clean
