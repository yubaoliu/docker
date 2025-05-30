# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
# Copyright (C) 2021, Yubao Liu, AISL, TOYOHASHI UNIVERSITY of TECHNOLOGY 
# Email: yubao.liu.ra@tut.jp 

# FROM nvidia/cudagl:11.4.0-devel-ubuntu20.04
ARG CUDA_VERSION
ARG CUDNN_VERSION

FROM ros:noetic-perception as ros-noetic
# FROM nvidia/cudagl:${CUDA_VERSION}-devel-ubuntu20.04
FROM nvidia/cuda:${CUDA_VERSION}-${CUDNN_VERSION}-devel-ubuntu20.04
MAINTAINER yubao.liu.ra@tut.jp 

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone \
    && rm /etc/localtime -f \
    && ln -s /usr/share/zoneinfo/Etc/GMT+8 /etc/localtime  \
    && apt-get update  \
    && apt-get install -q -y --no-install-recommends tzdata  -f\
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

COPY Extern/Ubuntu20/sources.list /etc/apt/sources.list

RUN mkdir -p ~/.pip && touch ~/.pip/pip.conf

COPY Extern/Ubuntu18/pip.conf ~/.pip/pip.conf

# Install tools for development
RUN apt-get update && \
    apt-get install -y software-properties-common \
    wget \
    curl \
    git \
    libssl-dev \
    apt-transport-https \
    ca-certificates \
    qt5-default \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*
 
# Install basic depencies
RUN apt-get update && \
    apt-get install -y software-properties-common \
    sudo \
    byobu \
    gdb \
    htop \
    locate \
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

# #--------------OpenGL -------------
# RUN dpkg --add-architecture i386 && \
#     apt-get update && apt-get install -y --no-install-recommends \
#         libxau6 libxau6:i386 \
#         libxdmcp6 libxdmcp6:i386 \
#         libxcb1 libxcb1:i386 \
#         libxext6 libxext6:i386 \
#         libx11-6 libx11-6:i386 && \
#     rm -rf /var/lib/apt/lists/*
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
# # COPY NGC-DL-CONTAINER-LICENSE /
# 
# # Required for non-glvnd setups.
# ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}:/usr/local/nvidia/lib:/usr/local/nvidia/lib64
# 
# RUN apt-get update && apt-get install -y --no-install-recommends \
#         pkg-config \
#         libglvnd-dev libglvnd-dev:i386 \
#         libgl1-mesa-dev libgl1-mesa-dev:i386 \
#         libegl1-mesa-dev libegl1-mesa-dev:i386 \
#         libgles2-mesa-dev libgles2-mesa-dev:i386 && \
#     rm -rf /var/lib/apt/lists/*
# #--------------------------------------------------

#------------ Install ROS ---------------
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list'
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
#     && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    # && apt-get update

ARG ROS_DISTRO
ENV ROS_DISTRO ${ROS_DISTRO}
# ENV ROS_DISTRO noetic

COPY --from=ros-noetic /opt/ros /opt/ros
COPY --from=ros-noetic /etc/ros /etc/ros

RUN /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && /bin/bash -c 'echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && /bin/bash -c 'echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    # && /bin/bash -c 'echo "deb http://mirrors.sjtug.sjtu.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Install ROS-Base packages
RUN apt-get update && apt-get install --no-install-recommends -y  \
    ros-${ROS_DISTRO}-desktop-full \
    python3-rosdep \
    python3-rosinstall \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

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

 
# update pip
# RUN curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python2  \
#     && curl -kL https://bootstrap.pypa.io/get-pip.py | python3 

# #Pangolin
# COPY Extern/Pangolin /tmp/Pangolin
# # RUN git clone https://github.com/stevenlovegrove/Pangolin.git \
# # RUN git clone  https://gitee.com/yubaoliu/Pangolin.git \
# RUN cd /tmp/Pangolin \
#     # && git checkout v0.6 \
#     && mkdir build \
#     && cd build \
#     && cmake .. -DCMAKE_BUILD_TYPE=Release \
#     && make -j 3 \
#     && make install \
#     && rm -rf /tmp/Pangolin

# Install tools for development
RUN apt-get update && \
    apt-get install -y xterm \
    lxterminal \
    vim \
    tmux \
    proxychains4 \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

# COPY Extern/proxychains.conf /etc/proxychains.conf
# # config ROS environment
# RUN proxychains4 rosdep init
# RUN proxychains4 rosdep update
#
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
 
# RUN rm /etc/apt/sources.list.d/cuda.list \
#     && rm /etc/apt/sources.list.d/nvidia-ml.list

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
    --fix-missing

# Install oh-my-zsh
COPY Extern/oh-myzsh-install.sh /tmp/oh-myzsh-install.sh

RUN chmod +x /tmp/oh-myzsh-install.sh  \
    &&  /tmp/oh-myzsh-install.sh \
    && chsh -s $(which zsh)

RUN mkdir -p ~/.vim/autoload \
    && cd ~  \
    && ln -s /root/dotfiles/.vimrc \
    && ln -s /root/dotfiles/.tmux.conf

COPY Extern/plug.vim /root/.vim/autoload/plug.vim
# --------------------------------------------

# ssh
RUN apt update \
    && apt install -y net-tools \
    openssh-server  \
    libceres-dev \
    x11-apps \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

# SSH config
RUN sed -i '/^#/!s/PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sudo service ssh restart \
    && echo "root:abcd1234"|chpasswd

# Install VScode
# RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key  add - \
# 	&& add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" \
# 	&& apt update && apt install -y code \
#     --fix-missing \
#     && rm -rf /var/lib/apt/lists/*

# for vscode
RUN sudo apt  update \
    && sudo apt install -y snap  flatpak
    # && sudo snap install -y code --classic

COPY Ubuntu20/local_config.zsh /root/local_config.zsh

# conda
RUN wget -c "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" \
    && bash Miniforge3-$(uname)-$(uname -m).sh -b -p "${HOME}/conda"

# setup entrypoint
COPY Extern/Ubuntu20/entrypoint.sh /root/entrypoint.sh
RUN chmod 755 /root/entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]

CMD ["bash"]
