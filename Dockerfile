FROM ubuntu:16.04

LABEL maintainer="pmcrofts@margic.com"

RUN apt-get update && apt-get -y install openjdk-8-jdk curl git-core && rm -rf /var/lib/apt/lists/*

RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
RUN apt-get install bazel && rm -rf /var/lib/apt/lists/*
