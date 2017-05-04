FROM ubuntu:16.04

MAINTAINER Nick Wang <chaoqingwang.nick@gmail.com>

RUN apt-get update && apt-get install -y git autopoint autoconf automake bison build-essential flex gawk gettext gperf libtool pkg-config zlib1g-dev libgmp3-dev libmpc-dev libmpfr-dev texinfo python-docutils mc

WORKDIR /opt
RUN git clone https://chaoqing@bitbucket.org/chaoqing/padavan-psg1218.git
WORKDIR /opt/padavan-psg1218/toolchain-mipsel
RUN ./clean_sources && ./build_toolchain

VOLUME /mnt

ENTRYPOINT /bin/bash
