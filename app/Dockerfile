## Python image
#FROM python:3
#LABEL maintainer="tmiddelkoop@internet2.edu"

# Full Debian image
FROM debian:11
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


## App dependencies
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y python3-pip && apt-get clean
RUN pip3 install flask

## App
WORKDIR /app
COPY api.py .

## Entry
ENV PORT 8080
EXPOSE 8080
ENTRYPOINT [ "python3", "/app/api.py" ]
