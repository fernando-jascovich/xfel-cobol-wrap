FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y open-cobol gcc

ENV APPDIR /run/cobolapp

RUN mkdir -p $APPDIR
VOLUME $APPDIR
WORKDIR $APPDIR
