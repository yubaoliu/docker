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

# Install Realsense
RUN apt update \
    && apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
    && add-apt-repository -y "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    librealsense2* 

RUN apt update  \
    && apt install -y xterm \
    lxterminal \
    vim

WORKDIR /root
