# syntax=docker/dockerfile:1
ARG application=audacious_minecraft

FROM debian:bullseye-slim
USER root
WORKDIR /${application}

RUN apt-get update \
    && apt-get -y dist-upgrade\
    && apt-get clean

RUN apt-get -y install nano \
    && apt-get -y install sudo \
    && apt-get -y install apt-utils \
    && apt-get -y install openjdk-17-jdk-headless \
    && apt-get -y install curl \
    && apt-get -y install supervisor

RUN apt-get autoremove \
    && apt-get clean

RUN mkdir server
COPY system/ /


EXPOSE 25565
EXPOSE 25575

CMD ["/usr/bin/supervisord"]

### docker build --no-cache --tag dns .
