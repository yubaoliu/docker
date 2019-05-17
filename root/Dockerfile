
FROM ubuntu:16.04
MAINTAINER yubaoliu89@gmail.com

SHELL ["/bin/bash", "-c"]
ENV GIT_SSL_NO_VERIFY 1

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y --fix-missing  \
        dirmngr \
        gnupg2 \
        build-essential \
        cmake \
        cmake-qt-gui \
        g++ \
        vim \
        git \
        wget \
        curl \
        tree \
        doxygen \
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
