FROM ubuntu:20.04

# Install dependencies

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y \
curl \
build-essential \
pkg-config \
libffi-dev \
libgmp-dev \
libssl-dev \
libtinfo-dev \
libsystemd-dev \
zlib1g-dev \
make \
g++ \
git \
jq \
libncursesw5 \
libtool \
autoconf \
locales \
libsodium-dev

#Install GHC
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

ENV PATH="/root/.ghcup/bin:${PATH}" 

RUN ghcup install ghc 8.10.4

#Install Cabal

RUN ghcup install cabal 3.4.0.0 
ENV PATH="/root/.ghcup/bin:/root/.cabal/bin:${PATH}"

# Clone Cardano source code

RUN git clone https://github.com/input-output-hk/cardano-node.git /usr/src/cardano-node

#Build libsodium

RUN git clone https://github.com/input-output-hk/libsodium && \ 
cd libsodium && \ 
git checkout 66f017f1 && \
./autogen.sh && \
./configure && \
make && \
make install

#Build Cardano

WORKDIR /usr/src/cardano-node 

RUN cabal update && \
cabal build all

ENTRYPOINT ["/usr/src/cardano-node/dist-newstyle/build/x86_64-linux/ghc-8.10.4/cardano-cli-1.30.1/x/cardano-cli/build/cardano-cli/cardano-cli"]