# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
# Copyright (C) 2021, Yubao Liu, AISL, TOYOHASHI UNIVERSITY of TECHNOLOGY 
# Email: yubao.liu.ra@tut.jp 

# FROM nvidia/cudagl:11.4.0-devel-ubuntu20.04
ARG CUDA_VERSION

FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu20.04
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

COPY sources.list /etc/apt/sources.list

RUN mkdir -p ~/.pip && touch ~/.pip/pip.conf

COPY pip.conf ~/.pip/pip.conf

ARG ROS_DISTRO
# ENV ROS_DISTRO noetic
ENV ROS_DISTRO ${ROS_DISTRO}

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
    proxychains4 \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

#--------------OpenGL -------------
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

# COPY NGC-DL-CONTAINER-LICENSE /

# Required for non-glvnd setups.
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/nvidia/lib:/usr/local/nvidia/lib64

RUN apt-get update && apt-get install -y --no-install-recommends \
        pkg-config \
        libglvnd-dev libglvnd-dev:i386 \
        libgl1-mesa-dev libgl1-mesa-dev:i386 \
        libegl1-mesa-dev libegl1-mesa-dev:i386 \
        libgles2-mesa-dev libgles2-mesa-dev:i386 && \
    rm -rf /var/lib/apt/lists/*
#--------------------------------------------------

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

RUN mkdir -p /root/catkin_ws/src \
    && bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash \
            && cd /root/catkin_ws \
            && catkin_make -DCMAKE_BUILD_TYPE=Release" \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc \
    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc


# -------------Install proxychain --------
# RUN git clone https://github.com/rofl0r/proxychains-ng.git \
#     && cd proxychains-ng \
#     && ./configure --prefix=/usr --sysconfdir=/etc \
#     && make \
#     && make install \
#     && make install-config 

COPY proxychains.conf /etc/proxychains.conf
# ----------------------

# config ROS environment
RUN proxychains4 rosdep init
RUN proxychains4 rosdep update

# update pip
# RUN curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2  \
#     && curl -kL https://bootstrap.pypa.io/get-pip.py | python3 

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

# Install tools for development
RUN apt-get update && \
    apt-get install -y xterm libcanberra-gtk-module lxterminal vim tmux \
    --fix-missing

# Sophus
# RUN git clone https://github.com/yubaoliu/Sophus.git \
# RUN git clone https://gitee.com/yubaoliu/Sophus.git \
#     && cd Sophus \
#     && git checkout master \
#     && mkdir build \
#     && cd build \
#     && cmake .. -DCMAKE_BUILD_TYPE=Release \
#     && make -j3 \
#     && make install 

 # G2O
# RUN git clone https://github.com/yubaoliu/g2o.git \
# RUN git clone https://gitee.com/yubaoliu/g2o.git \
#     && cd g2o \
#     && mkdir build \
#     && cd build \
#     && cmake .. -DCMAKE_BUILD_TYPE=Debug \
#     && make -j 3 \
#     && make install \
#     && cmake .. -DCMAKE_BUILD_TYPE=Release \
#     && make -j 3 \
#     && make install
  
# # install ros packages
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ros-melodic-ros-core=1.4.1-0* \
#     && rm -rf /var/lib/apt/lists/*
# 
# # setup entrypoint
# COPY ./ros_entrypoint.sh /

# ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
