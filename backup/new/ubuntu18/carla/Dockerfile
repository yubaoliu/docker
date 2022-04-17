ARG carla_version=latest

FROM nvidia/cudagl:11.0-devel-ubuntu18.04
MAINTAINER yubaoliu89@gmail.com
# FROM yubaoliu/root:ros-cuda10.0-cudnn7-ubuntu18.04 # FROM carlasim/carla:${carla_version} 

# Setup timezone
RUN echo 'Asia/Tokyo' > /etc/timezone && \
    rm -f /etc/localtime && \
    # echo 'Etc/UTC' > /etc/timezone && \
    # ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apt-get update && apt-get install -y tzdata

RUN apt update && apt install -y build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev libffi-dev wget libbz2-dev curl  libxerces-c-dev software-properties-common \
    lsb-core sudo locate \
    git \
    aria2
# libsqlite3-dev

# USER root
RUN apt-get update  \
    && apt install -y xterm lxterminal vim
 
# # Install dependencies
# RUN apt-get update \ 
#     && apt-get install -y wget software-properties-common lsb-core sudo locate \
#     && add-apt-repository -y ppa:ubuntu-toolchain-r/test \
#     && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add - \
#     # && apt-add-repository -y "deb http://apt.llvm.org/$(lsb_release -c --short)/ llvm-toolchain-$(lsb_release -c --short)-8 main" \
#     && apt-get update

RUN add-apt-repository universe \
    && apt install -y python2.7 python3 python3-pip python-setuptools

# Install required modules Pygame and Numpy
RUN  pip3 install --user pygame numpy

# RUN add-apt-repository ppa:oibaf/graphics-drivers \
#     && apt update \
#     && apt install -y libvulkan1 mesa-vulkan-drivers vulkan-utils mesa-vulkan-drivers:i386

# https://linuxconfig.org/install-and-test-vulkan-on-linux    
RUN add-apt-repository ppa:graphics-drivers/ppa \
    && apt  upgrade -y \
    && apt install -y  libvulkan1 vulkan-utils mesa-vulkan-drivers mesa-vulkan-drivers:i386

COPY ./requirements.txt . 
RUN  pip3 install -r requirements.txt

COPY ./entrypoint.sh /entrypoint.sh

# RUN add-apt-repository -y ppa:deadsnakes/ppa \
#     # && apt update \
     # & apt install -y python3.7

 
# There are two different ways to install CARLA

# Option A) Debian package installation
# This repository contains CARLA 0.9.10 and later. To install previous CARLA versions, change to a previous version of the docs using the pannel in the bottom right part of the window
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1AF1527DE64CB8D9 \
#     && add-apt-repository -y "deb [arch=amd64] http://dist.carla.org/carla $(lsb_release -sc) main" \
#     && apt-get update \
#     && apt-get install -y carla-simulator 

# sudo apt-get install carla-simulator=0.9.10-1 # install a specific CARLA version
# cd /opt/carla-simulator
# ./CarlaUE4.sh

# Option B) Package installation
#   Go to: https://github.com/carla-simulator/carla/blob/master/Docs/download.md
#   Download the desired package and additional assets
#   Extract the package
#   Extract the additional assets in `/Import`
#   Run CARLA (Linux).
# ./CarlaUE.sh
#---------------------------------- ROS -------------------------
# Add ROS repository
RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
    apt-get update && apt install -f && apt-get install -y ros-melodic-desktop-full

# Install ROS bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-rosinstall-generator \
    python-wstool

# Set up rosdep
RUN rosdep init
RUN rosdep update

### Create catkin workspace ###
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws
RUN bash -c "source /opt/ros/melodic/setup.bash && \
             catkin_make -DCMAKE_BUILD_TYPE=Release"

# Load ROS environment at docker exec bash
RUN echo "source /opt/ros/melodic/setup.bash" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
#---------------------------------------ROS END--------------------------------- 

RUN useradd -s /bin/bash -d /home/carla/ -m -G sudo carla
# USER carla

RUN  apt install tmux

RUN git clone https://github.com/yubaoliu/dotfiles.git ~/dotfiles \
    && cd ~/dotfiles \
    && ./install.sh \
    && ./deploy.sh 

    
ENTRYPOINT ["./entrypoint.sh"]
# ENV SDL_VIDEODRIVER=offscreen

CMD ["bash"]
