# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

FROM ubuntu:22.04
#MAINTAINER Teaclave Contributors <dev@teaclave.apache.org>
ENV DEBIAN_FRONTEND=noninteractive

# Build libpng12

RUN apt-get update && apt-get install -y \
    build-essential \
    zlib1g-dev \
    wget
RUN wget https://ppa.launchpadcontent.net/linuxuprising/libpng12/ubuntu/pool/main/libp/libpng/libpng_1.2.54.orig.tar.xz
RUN tar Jxfv libpng_1.2.54.orig.tar.xz
WORKDIR /libpng-1.2.54
RUN ./configure; make; make install
RUN ln -s /usr/local/lib/libpng12.so.0.54.0 /usr/lib/libpng12.so
RUN ln -s /usr/local/lib/libpng12.so.0.54.0 /usr/lib/libpng12.so.0

WORKDIR /
# Install dependencies for building OP-TEE

RUN apt-get update && \
    apt-get install -y \
    git \
    android-tools-adb \
    android-tools-fastboot \
    autoconf \
    automake \
    bc \
    bison \
    build-essential \
    ccache \
    cscope \
    curl \
    device-tree-compiler \
    expect \
    flex \
    ftp-upload \
    gcc-aarch64-linux-gnu \
    gcc-arm-linux-gnueabihf \
    gdisk \
    iasl \
    libattr1-dev \
    libcap-dev \
    libfdt-dev \
    libftdi-dev \
    libglib2.0-dev \
    libgmp-dev \
    libhidapi-dev \
    libmpc-dev \
    libncurses5-dev \
    libpixman-1-dev \
    libssl-dev \
    libtool \
    make \
    mtools \
    netcat \
    ninja-build \
    python3 \
    python3-cryptography \
    python3-pyelftools \
    python3-pycryptodome \
    python3-pyelftools \
    python3-serial \
    rsync \
    unzip \
    uuid-dev \
    xdg-utils \
    xterm \
    xz-utils \
    zlib1g-dev \
    wget \
    cpio \
    libcap-ng-dev \
    screen \
    libvdeplug-dev \
    libsdl2-dev \
    pip \
    ca-certificates

RUN pip install cryptography

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
  . $HOME/.cargo/env && \
  rustup target install aarch64-unknown-linux-gnu && \
  rustup default nightly-2023-12-18

ENV PATH="/root/.cargo/bin:$PATH"
