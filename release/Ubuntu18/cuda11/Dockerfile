# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
# Copyright (C) 2021, Yubao Liu, AISL, TOYOHASHI UNIVERSITY of TECHNOLOGY 
# Email: yubao.liu.ra@tut.jp 

# FROM nvidia/cudagl:11.4.0-devel-ubuntu20.04
ARG CUDA_VERSION

FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu18.04
MAINTAINER yubao.liu.ra@tut.jp 

ENV DEBIAN_FRONTEND noninteractive

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone \
    && ln -s /usr/share/zoneinfo/Etc/GMT+8 /etc/localtime  \
    && apt-get update  \
    && apt-get install -q -y --no-install-recommends tzdata \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

COPY sources.list /etc/apt/sources.list

RUN mkdir -p ~/.pip && touch ~/.pip/pip.conf

COPY pip.conf ~/.pip/pip.conf

ARG ROS_DISTRO
# ENV ROS_DISTRO noetic
ENV ROS_DISTRO ${ROS_DISTRO}

# Install the Nvidia cuDNN library missing in the parent image.
# https://gitlab.com/nvidia/cuda/blob/ubuntu16.04/10.1/devel/cudnn7/Dockerfile
# "ARG" is needed here, cannot remove it
# ARG CUDNN_VERSION
# ENV NVIDIA_CUDNN_VERSION=${CUDNN_VERSION}
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     libcudnn7=${CUDNN_VERSION} \
#     libcudnn7-dev=${CUDNN_VERSION} \
#     && apt-mark hold libcudnn7 \
#     && rm -rf /var/lib/apt/lists/*

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

# Install tools for development
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
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

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

# config ROS environment
# RUN rosdep init
COPY hosts /etc/hosts

RUN mkdir -p /root/catkin_ws/src \
    && bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash \
            && cd /root/catkin_ws \
            && catkin_make -DCMAKE_BUILD_TYPE=Release" \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc \
    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc


# Install tools for development
# RUN apt-get update && \
#     apt-get install -y lxterminal vim tmux

# COPY ./rosdep/20-default.list /etc/ros/rosdep/sources.list.d/20-default.list
# COPY ./rosdep/*  /etc/ros/rosdep/
RUN rosdep init
RUN rosdep update

RUN apt-get update && \
    apt-get install -y  lxterminal \
    # cmake-curses-gui \
    # autoconf \
    # automake \
    # cmake-qt-gui \
    # cmake-doc \
    vim \
    tmux \
    python3-pip \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

# update pip
# RUN curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python  \
#     && curl -kL https://bootstrap.pypa.io/get-pip.py | python3 
# RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# # install ros packages
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ros-melodic-ros-core=1.4.1-0* \
#     && rm -rf /var/lib/apt/lists/*
# 
# # setup entrypoint
# COPY ./ros_entrypoint.sh /

# ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
