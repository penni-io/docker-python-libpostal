FROM penniio/python:3.6

ARG VERSION=eae01d3e60501978d880e4ded15783daa28de7e5

# Build support tools
RUN apt-get update && \
    apt-get install -y \
        autoconf \
        automake \
        curl \
        git \
        libtool \
        pkg-config

# Checkout
WORKDIR /libpostal
RUN git clone https://github.com/openvenues/libpostal .
RUN git checkout $VERSION

# Build
RUN mkdir -p /opt/libpostal-data
RUN ./bootstrap.sh
RUN ./configure --datadir=/opt/libpostal-data
RUN make -j4

# Install
RUN make install
RUN ldconfig