## Python image
#FROM python:3
#LABEL maintainer="tmiddelkoop@internet2.edu"

# Full Debian image
FROM debian:10
LABEL maintainer="tmiddelkoop@internet2.edu"

# Basic install/update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils
RUN apt-get update && apt-get dist-upgrade -y && apt-get clean

# Development
RUN apt-get install -y git python3 ca-certificates build-essential procps curl unzip jq && apt-get clean
RUN apt-get install -y python3-pip && apt-get clean

## App
RUN pip3 install flask
WORKDIR /app
COPY api.py .

## Entry
ENV PORT 8080
EXPOSE 8080
ENTRYPOINT [ "python3", "/app/api.py" ]
