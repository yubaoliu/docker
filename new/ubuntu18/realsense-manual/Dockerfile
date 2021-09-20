ARG CUDA_VERSION=10.2
FROM nvidia/cudagl:$CUDA_VERSION-devel-ubuntu18.04
LABEL maintainer "yubao <yubao.liu.ra@tut.jp>"

RUN apt-get update && apt-get install -y --no-install-recommends \
   software-properties-common \
   cmake \
   git \
   libeigen3-dev \
   libjpeg-dev \
   libgl1-mesa-dev \
   libglew-dev \
   libsuitesparse-dev \
   libudev-dev \
   libusb-1.0-0-dev \
   libxkbcommon-x11-dev \
   openjdk-8-jdk \
   freeglut3-dev \
   zlib1g-dev \
   && rm -rf /var/lib/apt/lists/*

# OpenNI2
RUN apt-get update && apt-get install -y --no-install-recommends \
   libopenni2-dev \
   libopenni2-0 \
   openni2-utils  \
   openni2-doc \
   && rm -rf /var/lib/apt/lists/*

# realsense
RUN apt update \
    && apt install -y  sudo git libssl-dev libusb-1.0-0-dev pkg-config libgtk-3-dev \
    linux-headers-4.15.0-142-generic \
    && apt install -y libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev \
    && git clone https://github.com/IntelRealSense/librealsense.git \
    && mkdir -p /etc/udev/rules.d \
    && cd librealsense  \
    && ./scripts/setup_udev_rules.sh \
    && ./scripts/patch-realsense-ubuntu-lts.sh

RUN apt update  \
    && apt install -y xterm \
    lxterminal \
    vim

# Install Realsense

WORKDIR /root
