FROM ubuntu:16.04

LABEL maintainer="pmcrofts@margic.com"

# prerequisites for installing bazel
RUN apt-get update && apt-get -y install openjdk-8-jdk curl git-core python-dev build-essential make snapd && rm -rf /var/lib/apt/lists/*

# set up the bazel apt repo
RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
# install bazel
RUN apt-get update && apt-get -y install bazel && rm -rf /var/lib/apt/lists/*
# install kubectl for deploy
RUN snap install kubectl --classic
