# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
# Copyright (C) 2021, Yubao Liu, AISL, TOYOHASHI UNIVERSITY of TECHNOLOGY 
# Email: yubao.liu.ra@tut.jp 

# FROM nvidia/cudagl:11.4.0-devel-ubuntu20.04
ARG CUDA_VERSION
ARG CUDNN_VERSION

# FROM nvidia/cuda:${CUDA_VERSION}-${CUDNN_VERSION}-devel-ubuntu16.04
FROM ros:kinetic-perception as ros-kinetic
FROM nvidia/cudagl:${CUDA_VERSION}-devel-ubuntu16.04
MAINTAINER yubao.liu.ra@tut.jp 

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# RUN apt-key del A4B469963BF863CC
RUN rm /etc/apt/sources.list.d/cuda.list \
    && rm /etc/apt/sources.list.d/nvidia-ml.list

COPY Ubuntu16/sources.list /etc/apt/sources.list

RUN mkdir -p ~/.pip && touch ~/.pip/pip.conf
COPY Ubuntu16/pip.conf ~/.pip/pip.conf

RUN apt update \
    && apt install -f -y

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone \
    && rm /etc/localtime -f \
    && ln -s /usr/share/zoneinfo/Etc/GMT+8 /etc/localtime  \
    && apt-get update  \
    && apt-get install -q -y --no-install-recommends tzdata \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y software-properties-common \
    wget \
    curl \
    git \
    libssl-dev \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    qt5-default \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

 # Install cmake
# COPY Extern/CMake /tmp/CMake

RUN apt-get purge -y cmake

RUN git clone --recursive https://github.com/Kitware/CMake.git \
    && cd CMake \
    && git checkout v3.18.1 \
    && ./bootstrap --qt-gui \
    && make \
    && make install \
    && rm ./Cmake -rf 

    # && wget -c https://github.com/Kitware/CMake/releases/download/v3.18.1/cmake-3.18.1.tar.gz \
    # && tar -xzvf cmake-3.18.1.tar.gz \
    # && git checkout v3.18.1 \

# Install tools for development
RUN apt-get update && \
    apt-get install -y software-properties-common \
    sudo \
    byobu \
    gdb \
    htop \
    locate \
    wget \
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
    libyaml-dev \
    dirmngr \
    gnupg \
    build-essential \
    libffi-dev \
    libncurses5-dev \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    x11proto-gl-dev  \
    libcanberra-gtk-module \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*


COPY Extern/proxychains-ng /tmp/proxychains-ng

# -------------Install proxychain --------
# RUN git clone https://github.com/rofl0r/proxychains-ng.git \
RUN cd /tmp/proxychains-ng \
    && ./configure --prefix=/usr --sysconfdir=/etc \
    && make \
    && make install \
    && make install-config  \
    && cd .. \
    && rm /tmp/proxychains-ng -rf

#  ##-------------- OpenGL (https://gitlab.com/nvidia/container-images/opengl/-/blob/ubuntu18.04/base/Dockerfile)--------------------
# RUN dpkg --add-architecture i386 && \
#     apt-get update && apt-get install -y --no-install-recommends \
#         libxau6 libxau6:i386 \
#         libxdmcp6 libxdmcp6:i386 \
#         libxcb1 libxcb1:i386 \
#         libxext6 libxext6:i386 \
#         libx11-6 libx11-6:i386 && \
#     rm -rf /var/lib/apt/lists/*
# 
# 
# # nvidia-container-runtime
# ENV NVIDIA_VISIBLE_DEVICES \
#         ${NVIDIA_VISIBLE_DEVICES:-all}
# ENV NVIDIA_DRIVER_CAPABILITIES \
#         ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics,compat32,utility
# 
# RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
#     echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
# 
# # Required for non-glvnd setups.
# ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/nvidia/lib:/usr/local/nvidia/lib64
# 
# # glvnd devel
# # RUN git clone https://github.com/KhronosGroup/OpenGL-Registry.git && cd OpenGL-Registry && \
# #     git checkout 681c365c012ac9d3bcadd67de10af4730eb460e0 && \
# #     cp -r api/GL /usr/local/include
# # RUN git clone https://github.com/KhronosGroup/EGL-Registry.git && cd EGL-Registry && \
# #     git checkout 0fa0d37da846998aa838ed2b784a340c28dadff3 && \
# #     cp -r api/EGL api/KHR /usr/local/include
# # RUN git clone --branch=mesa-17.3.3 --depth=1 https://gitlab.freedesktop.org/mesa/mesa.git && cd mesa && \
# #     cp include/GL/gl.h include/GL/gl_mangle.h /usr/local/include/GL/
# 
# COPY extern /root/extern
# RUN cd /root/extern \
# 	&& cp -r api/EGL api/KHR /usr/local/include \
# 	&& cp -r api/GL /usr/local/include \
# 	&& cp gl.h gl_mangle.h /usr/local/include/GL/
# 
# RUN apt-get update && apt-get install -y --no-install-recommends \
#         pkg-config \
#         libxau-dev libxau-dev:i386 \
#         libxdmcp-dev libxdmcp-dev:i386 \
#         libxcb1-dev libxcb1-dev:i386 \
#         libxext-dev libxext-dev:i386 \
#         libx11-dev libx11-dev:i386 && \
#     rm -rf /var/lib/apt/lists/*
# ##----------------End OPenGL ------------------

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
    libwayland-dev \
	libceres-dev \
    && rm -rf /var/lib/apt/lists/*

#------------ Install ROS ---------------
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list'
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
#     && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    # && apt-get update

ARG ROS_DISTRO
# ENV ROS_DISTRO kinetic
ENV ROS_DISTRO ${ROS_DISTRO}

RUN /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
   && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654  \
   && sudo apt update

# && /bin/bash -c 'echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
#     && /bin/bash -c 'echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
#     && /bin/bash -c 'echo "deb http://mirrors.sjtug.sjtu.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
 
COPY --from=ros-kinetic /opt/ros /opt/ros
COPY --from=ros-kinetic /etc/ros /etc/ros

# Install ROS-Base packages
RUN apt-get update \
    && apt-get install --no-install-recommends -y  \
    ros-${ROS_DISTRO}-desktop-full \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

# Install ROS bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-rosinstall-generator \
    python-wstool \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

# Install tools for development
RUN apt-get update && \
    apt-get install -y xterm lxterminal vim tmux \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

COPY Common/proxychains.conf /etc/proxychains.conf

# config ROS environment
# RUN rosdep init
RUN rosdep update

# RUN rosdep init
RUN rosdep update

RUN mkdir -p /root/catkin_ws/src \
    && bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash \
            && cd /root/catkin_ws \
            && catkin_make -DCMAKE_BUILD_TYPE=Release" \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc \
    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

# RUN apt-get update \
#     && apt-get install -y --no-install-recommends \

# # Test GUI
# Install Pangolin
# COPY Extern/Pangolin /tmp/Pangolin

# RUN git clone https://gitee.com/yubaoliu/Pangolin.git  \
# RUN git clone https://github.com/stevenlovegrove/Pangolin.git \
RUN git clone --recursive https://github.com/stevenlovegrove/Pangolin.git \
    && cd Pangolin \
	&& git checkout v0.6 \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make -j5 \
    && make install \
    && cd ../../ && rm ./Pangolin -r

# update pip
# RUN curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python  \
#     && curl -kL https://bootstrap.pypa.io/get-pip.py | python3 

# Config VIM, TMUX and Shell
COPY Extern/dotfiles /root/dotfiles

RUN apt update  \
    && apt install -y zsh \
    global \
    ctags \
    exuberant-ctags \
    python-pygments \
    vim-gtk \
    astyle \
    clang-format \
    python3-pip \
    python-autopep8 \
    gedit \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

# install pip2
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py \
    && python2 get-pip.py \
    && pip --version

# Install oh-my-zsh
COPY Common/oh-myzsh-install.sh /tmp/oh-myzsh-install.sh

RUN chmod +x /tmp/oh-myzsh-install.sh \
    && /tmp/oh-myzsh-install.sh \
    && chsh -s $(which zsh)

RUN pip3 install autopep8  yapf \
    && mkdir -p ~/.vim/autoload \
    && cd ~  \
    && ln -s /root/dotfiles/.vimrc \
    && ln -s /root/dotfiles/.tmux.conf

COPY Common/plug.vim /root/.vim/autoload/plug.vim

# "Install ruby"
RUN sudo apt-add-repository -y ppa:brightbox/ruby-ng  \
    && apt-get update \
    && apt install -y ruby ruby-dev \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

COPY Extern/rbenv /root/.rbenv

# ssh
RUN apt update \
    && apt install -y net-tools \
    openssh-server  \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i '/^#/!s/PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sudo service ssh restart \
    && echo "root:abcd1234"|chpasswd

# Install VScode
# COPY Extern/vscode /root/vscode
# RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key  add - \
# 	&& add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" \
# 	&& apt update && apt install -y code \
#     --fix-missing \
#     && rm -rf /var/lib/apt/lists/*

# RUN cd /root/vscode \
#     && wget -c https://github.com/microsoft/vscode-cpptools/releases/download/v1.10.7/cpptools-linux.vsix \
#     && code --install-extension cpptools-linux.vsix  \
#     && code --install-extension ms-iot.vscode-ros-0.8.2.vsix \
#     && code --no-sandbox --user-data-dir /root --install-extension twxs.cmake-0.0.17.vsix

COPY Common/.Xdefaults /root/.Xdefaults

# setup entrypoint
COPY Ubuntu16/entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]

# ENV NVIDIA_DRIVER_CAPABILITIES compute,display,graphics,utility,video
CMD ["bash"]
