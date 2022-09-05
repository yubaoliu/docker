# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
# Copyright (C) 2021, Yubao Liu, AISL, TOYOHASHI UNIVERSITY of TECHNOLOGY 
# Email: yubao.liu.ra@tut.jp 

# FROM nvidia/cudagl:11.4.0-devel-ubuntu20.04
ARG CUDA_VERSION
ARG CUDNN_VERSION

# FROM nvidia/cuda:${CUDA_VERSION}-${CUDNN_VERSION}-devel-ubuntu18.04
FROM ros:melodic-perception as ros-melodic
FROM nvidia/cudagl:${CUDA_VERSION}-devel-ubuntu18.04
MAINTAINER yubao.liu.ra@tut.jp 

ENV DEBIAN_FRONTEND noninteractive

# RUN apt-key del A4B469963BF863CC
RUN rm /etc/apt/sources.list.d/cuda.list -r \
    && rm /etc/apt/sources.list.d/nvidia-ml.list -f

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone \
    && rm /etc/localtime -f \
    && ln -s /usr/share/zoneinfo/Etc/GMT+8 /etc/localtime  \
    && apt-get update -y  \
    && apt-get install -q -y --no-install-recommends tzdata \
    && rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# COPY Extern/Ubuntu18/hosts /etc/hosts

COPY Extern/Ubuntu18/sources.list /etc/apt/sources.list

# Install tools for development
RUN apt-get update && \
    apt-get install -y software-properties-common \
    wget \
    curl \
    sudo \
    git \
    libssl-dev \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    qt5-default \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*

 # create a non-root user
ARG USER_ID=1000
RUN useradd -m --no-log-init --system  --uid ${USER_ID} ubuntu
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && echo "ubuntu:abcd1234"|sudo chpasswd \
    && sudo usermod -a -G sudo ubuntu 

USER ubuntu
WORKDIR /home/ubuntu

RUN mkdir -p ~/.pip && touch ~/.pip/pip.conf

COPY --chown=ubuntu:ubuntu Extern/Ubuntu18/pip.conf ~/.pip/pip.conf

# Install cmake
COPY --chown=ubuntu:ubuntu Extern/CMake /tmp/CMake
RUN sudo apt-get purge -y cmake \
    && cd /tmp/CMake \
    # && wget -c https://github.com/Kitware/CMake/releases/download/v3.18.1/cmake-3.18.1.tar.gz \
    # && tar -xzvf cmake-3.18.1.tar.gz \
    # && cd /tmp/cmake-3.18.1 \
    && ./bootstrap --qt-gui \
    && make \
    && sudo make install \
    && rm /tmp/CMake  -rf 

# Install basic depencies
RUN sudo apt-get update && \
    sudo apt-get install -y software-properties-common \
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
    python3-dev \
    python3-pip \
    python3-distutils \
    python3-opencv \
    libxkbcommon-dev \
    libc++-dev  \
    ctags \
    net-tools \
    openssh-server  \
    --fix-missing \
    && sudo rm -rf /var/lib/apt/lists/*

#---------------------------------------
# COPY Extern/proxychains-ng /tmp/proxychains-ng
# 
# # -------------Install proxychain --------
# # RUN git clone https://github.com/rofl0r/proxychains-ng.git \
# RUN cd /tmp/proxychains-ng \
#     && ./configure --prefix=/usr --sysconfdir=/etc \
#     && make \
#     && make install \
#     && make install-config  \
#     && cd .. \
#     && rm /tmp/proxychains-ng -rf

# ##-------------- OpenGL (https://gitlab.com/nvidia/container-images/opengl/-/blob/ubuntu18.04/base/Dockerfile)--------------------
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
# ##----------------------------------

# Dependences and tools, e.g., OpenGL
RUN sudo apt-get update \
    && sudo apt-get install -y --no-install-recommends \
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
    --fix-missing \
    && sudo rm -rf /var/lib/apt/lists/*


#------------ Install ROS ---------------
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list'
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
#     && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    # && apt-get update

ARG ROS_DISTRO
# ENV ROS_DISTRO melodic
ENV ROS_DISTRO ${ROS_DISTRO}

USER root
RUN /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && /bin/bash -c 'echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && /bin/bash -c 'echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && /bin/bash -c 'echo "deb http://mirrors.sjtug.sjtu.edu.cn/ros/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

COPY --from=ros-melodic /opt/ros /opt/ros
COPY --from=ros-melodic /etc/ros /etc/ros

# Install ROS-Base packages
RUN sudo apt update \
    && sudo apt-get install --no-install-recommends -y  \
    ros-${ROS_DISTRO}-desktop-full \
    --fix-missing \
    && sudo rm -rf /var/lib/apt/lists/*

# Install ROS bootstrap tools
RUN sudo apt-get update \
    && sudo apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-rosinstall-generator \
    python-wstool \
    --fix-missing \
    && sudo rm -rf /var/lib/apt/lists/*

USER ubuntu
RUN mkdir -p $HOME/catkin_ws/src \
    && bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash \
            && cd $HOME/catkin_ws \
            && catkin_make -DCMAKE_BUILD_TYPE=Release" \
    && echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> $HOME/.bashrc \
    && echo "source $HOME/catkin_ws/devel/setup.bash" >> $HOME/.bashrc

# COPY proxychains.conf /etc/proxychains.conf

# ## Proxy is needed
# # COPY ./rosdep/20-default.list /etc/ros/rosdep/sources.list.d/20-default.list
# # COPY ./rosdep/*  /etc/ros/rosdep/
# RUN proxychains4 rosdep init
# RUN proxychains4 rosdep update

# Editors
RUN sudo apt-get update && \
    sudo apt-get install -y xterm lxterminal \
    vim \
    tmux \
    --fix-missing \
    && sudo rm -rf /var/lib/apt/lists/*

# Test GUI
COPY --chown=ubuntu:ubuntu Extern/Pangolin /tmp/Pangolin
# RUN git clone https://gitee.com/yubaoliu/Pangolin.git  \
# RUN git clone https://github.com/stevenlovegrove/Pangolin.git \
RUN cd /tmp/Pangolin \
    && mkdir build \
    && cd build \
    && cmake .. \
    && cmake --build . \
    && sudo make install \
    && rm /tmp/Pangolin -r

# update pip
# RUN curl -kL https://bootstrap.pypa.io/pip/2.7/get-pip.py | python  \
#     && curl -kL https://bootstrap.pypa.io/get-pip.py | python3 
# RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# RUN rm /etc/apt/sources.list.d/cuda.list \
#     && rm /etc/apt/sources.list.d/nvidia-ml.list

RUN sudo apt update  \
    && sudo apt install -y zsh \
    global \
    exuberant-ctags \
    python-pygments \
    vim-gtk \
    astyle \
    clang-format \
    python-autopep8 \
    --fix-missing \
    && sudo rm -rf /var/lib/apt/lists/* \
    && pip3 install autopep8  yapf

# ssh
# RUN apt update \
#     && apt install -y net-tools \
#     openssh-server  \
#     --fix-missing \
#     && rm -rf /var/lib/apt/lists/*

RUN sudo sed -i '/^#/!s/PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sudo service ssh restart \
    && echo "root:abcd1234"| sudo chpasswd


RUN sudo apt-get update -y \
    && sudo apt install -y libceres-dev \
    xdg-utils \
    --fix-missing \
    && sudo rm -rf /var/lib/apt/lists/*

# RUN wget -c https://az764295.vo.msecnd.net/stable/e4503b30fc78200f846c62cf8091b76ff5547662/code_1.70.2-1660629410_amd64.deb \
#     && dpkg -i code_1.70.2-1660629410_amd64.deb
# 
# RUN apt install libxkbfile

# RUN  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key  add - \
# 	&& add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" \
# 	&& apt update && apt install -y code \
#     --fix-missing \
#     && rm -rf /var/lib/apt/lists/*

ARG VSCODE_COMMIT_ID

RUN rm ~/.vscode-server/bin/* -rf \
    && mkdir -p ~/.vscode-server/bin \
    && cd ~/.vscode-server/bin  \
    && wget -c https://vscode.cdn.azure.cn/stable/${VSCODE_COMMIT_ID}/vscode-server-linux-x64.tar.gz --no-check-certificate \
    && tar -zxf vscode-server-linux-x64.tar.gz \
    && mv vscode-server-linux-x64 ${VSCODE_COMMIT_ID} 

ENV PATH ${PATH}:/home/ubuntu/.vscode-server/bin/${VSCODE_COMMIT_ID}/bin

# pycharm 
RUN wget -c https://download.jetbrains.com.cn/python/pycharm-community-2022.2.1.tar.gz --no-check-certificate \
    && tar -zxvf pycharm-community-2022.2.1.tar.gz 

ENV PATH ${PATH}:/home/ubuntu/pycharm-community-2022.2.1/bin

# Install VScode and extensions
COPY --chown=ubuntu:ubuntu Extern/vscode /home/ubuntu/vscode

# RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --dry-run
# RUN wget -c https://github.com/coder/code-server/releases/download/v4.4.0/code-server_4.4.0_amd64.deb \
#     && dpkg -i code-server_4.4.0_amd64.deb 
# RUN curl -fsSL https://code-server.dev/install.sh | sh &
    # && wget -c https://github.com/coder/code-server/releases/download/v4.4.0/code-server-4.4.0-linux-amd64.tar.gz \

# RUN cd /root/vscode \
#     && wget -c https://github.com/microsoft/vscode-cpptools/releases/download/v1.10.7/cpptools-linux.vsix \
#     && code --no-sandbox --user-data-dir /root --install-extension cpptools-linux.vsix  \
#     && code --no-sandbox --user-data-dir /root --install-extension ms-iot.vscode-ros-0.8.2.vsix \
#     && code --no-sandbox --user-data-dir /root --install-extension twxs.cmake-0.0.17.vsix

# RUN cd $HOME/vscode \
#     && wget -c https://github.com/microsoft/vscode-cpptools/releases/download/v1.10.7/cpptools-linux.vsix \
#     && code-server  --user-data-dir $HOME/.vscode-server --install-extension cpptools-linux.vsix  \
#     && code-server  --user-data-dir $HOME/.vscode-server --install-extension ms-iot.vscode-ros-0.8.2.vsix \
#     && code-server  --user-data-dir $HOME/.vscode-server --install-extension twxs.cmake-0.0.17.vsix \
#     # && code-server  --user-data-dir $HOME/.vscode-server --install-extension ms-python.python-2022.15.12451011.vsix \
#     && code-server  --user-data-dir $HOME/.vscode-server --install-extension ms-python.python-2022.8.1.vsix

# USER ubuntu

RUN cd /home/ubuntu/vscode \
    && wget -c https://github.com/microsoft/vscode-cpptools/releases/download/v1.10.7/cpptools-linux.vsix \
    && code-server  --install-extension cpptools-linux.vsix  \
    && code-server  --install-extension ms-iot.vscode-ros-0.8.2.vsix \
    && code-server  --install-extension twxs.cmake-0.0.17.vsix \
    && code-server  --install-extension ms-python.python-2022.8.1.vsix
    # && code-server --install-extension ms-python.python-2022.15.12451011.vsix \

# Config VIM, TMUX and Shell
COPY --chown=ubuntu:ubuntu Extern/dotfiles /home/ubuntu/dotfiles

# Install oh-my-zsh
# COPY --chown=ubunntu:ubuntu Extern/oh-myzsh-install.sh /tmp/oh-myzsh-install.sh
# 
# RUN /tmp/oh-myzsh-install.sh \
#     && chsh -s $(which zsh)

RUN mkdir -p ~/.vim/autoload \
    && cd ~  \
    && ln -s $HOME/dotfiles/.vimrc \
    && ln -s $HOME/dotfiles/.tmux.conf

COPY --chown=ubuntu:ubuntu Extern/plug.vim $HOME/.vim/autoload/plug.vim

RUN sudo apt update -y \
    && sudo apt-get install -y bash-completion

ENV SHELL /bin/bash

# setup entrypoint
COPY --chown=ubuntu:ubuntu Extern/Ubuntu18/entrypoint.sh /home/ubuntu/entrypoint.sh
RUN sudo chmod 755 $HOME/entrypoint.sh
ENTRYPOINT ["/home/ubuntu/entrypoint.sh"]

# From https://github.com/NVIDIA/nvidia-container-runtime/blob/master/README.md
# compute: required for CUDA and OpenCL applications.
# display: required for leveraging X11 display.
# graphics: required for running OpenGL and Vulkan applications.
# utility: required for using nvidia-smi and NVML.
# video: required for using the Video Codec SDK. Required by ZED SDK.
ENV NVIDIA_DRIVER_CAPABILITIES compute,display,graphics,utility,video

CMD ["bash"]
