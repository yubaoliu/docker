# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
# Copyright (C) 2021, Yubao Liu, AISL, TOYOHASHI UNIVERSITY of TECHNOLOGY 
# Email: yubao.liu.ra@tut.jp 

# FROM nvidia/cudagl:11.4.0-devel-ubuntu20.04
ARG CUDA_VERSION

FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu20.04
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
    sudo \
    byobu \
    gdb \
    htop \
    locate \
    wget \
    git \
    curl \
    zip \
    unzip \
    g++ \
    libevent-dev \
    bison \
    byacc \
    autotools-dev \
    automake \
    libgdbm-dev \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    autoconf \
    bison \
    libyaml-dev \
    dirmngr \
    gnupg \
    git \
    build-essential \
    libffi-dev \
    libncurses5-dev \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    cmake-curses-gui \
    cmake-qt-gui \
    cmake-doc \
    libxkbcommon-dev  \
    libglew-dev \
    libgoogle-glog-dev \
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
    # && /bin/bash -c 'echo "deb http://mirrors.sjtug.sjtu.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654  \
    && apt update \
    && apt install -f

# Install ROS-Base packages
RUN apt-get install --no-install-recommends -y  \
    ros-${ROS_DISTRO}-desktop-full \
    --fix-missing

RUN apt install -y python3-rosdep \
    python3-rosinstall

# Install tools for development
RUN apt-get update && \
    apt-get install -y lxterminal vim tmux


# config ROS environment
RUN rosdep init
# RUN rosdep update

RUN mkdir -p /root/catkin_ws/src \
    && bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash \
            && cd /root/catkin_ws \
            && catkin_make -DCMAKE_BUILD_TYPE=Release" \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc \
    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

# update pip
RUN curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2  \
    && curl -kL https://bootstrap.pypa.io/get-pip.py | python3 

#Pangolin
# RUN git clone https://github.com/stevenlovegrove/Pangolin.git \
RUN git clone  https://gitee.com/yubaoliu/Pangolin.git \
    && cd Pangolin \
    && git checkout v0.6 \
    && mkdir build \
    && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
    && make -j 3 \
    && make install

# Sophus
# RUN git clone https://github.com/yubaoliu/Sophus.git \
RUN git clone https://gitee.com/yubaoliu/Sophus.git \
    && cd Sophus \
    && git checkout master \
    && mkdir build \
    && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
    && make -j3 \
    && make install 

 # G2O
# RUN git clone https://github.com/yubaoliu/g2o.git \
RUN git clone https://gitee.com/yubaoliu/g2o.git \
    && cd g2o \
    && mkdir build \
    && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Debug \
    && make -j 3 \
    && make install \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
    && make -j 3 \
    && make install
  
# RUN apt install  -y cmake-curses-gui \
#     cmake-qt-gui \
#     cmake-doc \
#     libxkbcommon-dev  \
#     libglew-dev \
#     libgoogle-glog-dev

# # install ros packages
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ros-melodic-ros-core=1.4.1-0* \
#     && rm -rf /var/lib/apt/lists/*
# 
# # setup entrypoint
# COPY ./ros_entrypoint.sh /

# ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
