#!/bin/bash

set -e
apt-get update 
apt-get install --no-install-recommends --no-install-suggests -y \
                libcurl4-openssl-dev \
                build-essential \
                cmake \
                git \
                ca-certificates

# Build bazel
apt-get install --no-install-recommends --no-install-suggests -y \
         curl \
         ca-certificates \
         openjdk-8-jdk
echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" \
      | tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
apt-get update
apt-get install --no-install-recommends --no-install-suggests -y \
         bazel
apt-get upgrade -y bazel

# Build OpenTracing
cd /
git clone https://github.com/opentracing/opentracing-cpp.git
cd opentracing-cpp
mkdir .build && cd .build
cmake -DBUILD_TESTING=OFF ..
make && make install
