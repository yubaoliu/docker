
FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04
MAINTAINER yubaoliu89@gmail.com

SHELL ["/bin/bash", "-c"]
ENV GIT_SSL_NO_VERIFY 1

RUN apt-get update && apt-get install -y --fix-missing  \
        build-essential \
        cmake \
        vim \
        git \
        wget \
        curl \
        tree \
        libatlas-base-dev \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        python-dev \
        python-numpy \
        python-pip \
        python-scipy \
        lsb-release \
        python-wstool \
        bash-completion \
        libsuitesparse-dev \
        libtbb-dev \
        libeigen3-dev \
        software-properties-common \
        net-tools \
        iputils-ping \
        python-wstool && \
        apt-get -y upgrade && \
        apt-get autoremove && \
        rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
