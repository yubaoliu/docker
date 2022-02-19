# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
# Copyright (C) 2021, Yubao Liu, AISL, TOYOHASHI UNIVERSITY of TECHNOLOGY 
# Email: yubao.liu.ra@tut.jp 

# FROM nvidia/cudagl:11.4.0-devel-ubuntu20.04
ARG CUDA_VERSION

FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu18.04
MAINTAINER yubao.liu.ra@tut.jp 

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone \
    && ln -s /usr/share/zoneinfo/Etc/GMT+8 /etc/localtime  \
    && apt-get update  \
    && apt-get install -q -y --no-install-recommends tzdata \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# config ROS environment
# RUN rosdep init
COPY hosts /etc/hosts

COPY sources.list /etc/apt/sources.list

RUN mkdir -p ~/.pip && touch ~/.pip/pip.conf

COPY pip.conf ~/.pip/pip.conf

ARG ROS_DISTRO
# ENV ROS_DISTRO noetic
ENV ROS_DISTRO ${ROS_DISTRO}

# Install tools for development
RUN apt-get update && \
    apt-get install -y software-properties-common \
    wget \
    curl \
    libssl-dev \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    qt5-default \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*
 
# Install cmake
RUN apt-get purge -y cmake \
    && cd /tmp \
    && wget -c https://github.com/Kitware/CMake/releases/download/v3.18.1/cmake-3.18.1.tar.gz \
    && tar -xzvf cmake-3.18.1.tar.gz \
    && cd cmake-3.18.1 \
    && ./bootstrap --qt-gui && make && make install \
    && rm cmake-3.18.1 -rf 

# Install basic depencies
RUN apt-get update && \
    apt-get install -y software-properties-common \
    sudo \
    byobu \
    gdb \
    htop \
    locate \
    git \
    zip \
    unzip \
    build-essential \
    g++ \
    bison \
    byacc \
    libgdbm-dev \
    libevent-dev \
    autotools-dev \
    libreadline-dev \
    libyaml-dev \
    zlib1g-dev \
    libncurses5-dev \
    libreadline-dev \
    libffi-dev \
    dirmngr \
    gnupg \
    inetutils-tools \
    inetutils-ping \
    python3-pip \
    python3-distutils \
    libxkbcommon-dev \
    libc++-dev  \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

##-------------- OpenGL (https://gitlab.com/nvidia/container-images/opengl/-/blob/ubuntu18.04/base/Dockerfile)--------------------
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y --no-install-recommends \
        libxau6 libxau6:i386 \
        libxdmcp6 libxdmcp6:i386 \
        libxcb1 libxcb1:i386 \
        libxext6 libxext6:i386 \
        libx11-6 libx11-6:i386 && \
    rm -rf /var/lib/apt/lists/*

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
        ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
        ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compat32,utility

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

# Required for non-glvnd setups.
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/nvidia/lib:/usr/local/nvidia/lib64

RUN apt-get update && apt-get install -y --no-install-recommends \
        pkg-config \
        libglvnd-dev libglvnd-dev:i386 \
        libgl1-mesa-dev libgl1-mesa-dev:i386 \
        libegl1-mesa-dev libegl1-mesa-dev:i386 \
        libgles2-mesa-dev libgles2-mesa-dev:i386 && \
    rm -rf /var/lib/apt/lists/*
##----------------------------------

# Dependences and tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    libjpeg-dev libpng-dev \
    libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
    libdc1394-22-dev libraw1394-dev libopenni-dev   \
    wayland-protocols \
    mesa-common-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    libglew-dev \
    libeigen3-dev \
    libboost-dev  \
    libboost-thread-dev \
    libboost-filesystem-dev \
    libwayland-dev

#------------ Install ROS ---------------
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list'
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
#     && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    # && apt-get update

RUN /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && /bin/bash -c 'echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && /bin/bash -c 'echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && /bin/bash -c 'echo "deb http://mirrors.sjtug.sjtu.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654  \
    && apt update \
    && apt install -f

# Install ROS-Base packages
RUN apt-get install --no-install-recommends -y  \
    ros-${ROS_DISTRO}-desktop-full \
    --fix-missing

# Install ROS bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-rosinstall-generator \
    python-wstool \
    --fix-missing

RUN mkdir -p /root/catkin_ws/src \
    && bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash \
            && cd /root/catkin_ws \
            && catkin_make -DCMAKE_BUILD_TYPE=Release" \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc \
    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
#---------------------------------------

# -------------Install proxychain --------
RUN git clone https://github.com/rofl0r/proxychains-ng.git \
    && cd proxychains-ng \
    && ./configure --prefix=/usr --sysconfdir=/etc \
    && make \
    && make install \
    && make install-config 

COPY proxychains.conf /etc/proxychains.conf
# ----------------------

# Editors
RUN apt-get update && \
    apt-get install -y  lxterminal \
    vim \
    tmux \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

## Proxy is needed
# COPY ./rosdep/20-default.list /etc/ros/rosdep/sources.list.d/20-default.list
# COPY ./rosdep/*  /etc/ros/rosdep/
RUN proxychains4 rosdep init
RUN proxychains4 rosdep update

# Test GUI
RUN git clone https://gitee.com/yubaoliu/Pangolin.git  \
# RUN git clone https://github.com/stevenlovegrove/Pangolin.git \
    && cd Pangolin \
    && mkdir build \
    && cd build \
    && cmake .. \
    && cmake --build . \
    && make install

# update pip
# RUN curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python  \
#     && curl -kL https://bootstrap.pypa.io/get-pip.py | python3 
# RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# # setup entrypoint
# COPY ./ros_entrypoint.sh /

# ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
