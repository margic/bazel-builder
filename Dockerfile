FROM ubuntu:16.04

LABEL maintainer="pmcrofts@margic.com"

# prerequisites for installing bazel
RUN apt-get update && apt-get -y install openjdk-8-jdk curl git-core python-dev build-essential make && rm -rf /var/lib/apt/lists/*

# set up the bazel apt repo
RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
# install bazel
RUN apt-get update && apt-get -y install bazel && rm -rf /var/lib/apt/lists/*
# install kubectl for deploy
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

COPY docker-credential-ecr-login bin/docker-credential-ecr-login
COPY config.json ~/.docker/config.json
RUN export PATH=$PATH:$PWD/bin/
