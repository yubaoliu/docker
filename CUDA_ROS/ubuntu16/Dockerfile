# versiion
ARG cuda_version=10.2
# ARG cudnn_version=7
ARG ubuntu_version=16.04
#ARG nvidia_cudnn_version=7.1.3.16-1+cuda9.0
ARG nvidia_cudnn_version=7.6.5.32-1+cuda10.2

FROM nvidia/cudagl:${cuda_version}-devel-ubuntu${ubuntu_version}
# FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel-ubuntu16.04
#FROM ubuntu:16.04

# base image
MAINTAINER yubaoliu89@gmail.com

# ENV LANG C.UTF-8
# ENV LC_ALL C.UTF-8

# Setup timezone
RUN echo 'Asia/Tokyo' > /etc/timezone && \
    rm -f /etc/localtime && \
    # echo 'Etc/UTC' > /etc/timezone && \
    # ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apt-get update && apt-get install -y tzdata


# Install the Nvidia cuDNN library missing in the parent image.
# https://gitlab.com/nvidia/cuda/blob/ubuntu16.04/10.1/devel/cudnn7/Dockerfile
# "ARG" is needed here, cannot remove it
ARG nvidia_cudnn_version    
ENV NVIDIA_CUDNN_VERSION=${nvidia_cudnn_version}
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn7=${NVIDIA_CUDNN_VERSION} \
    libcudnn7-dev=${NVIDIA_CUDNN_VERSION} \
    && apt-mark hold libcudnn7 \
    && rm -rf /var/lib/apt/lists/*

##############################################3
# Install tools for development
RUN apt-get update && \
    apt-get install -y software-properties-common \
    sudo \
    byobu \
    gdb \
    htop \
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
    zlib1g-dev && \
    apt install -f \
    && rm -rf /var/lib/apt/lists/*

##############################################3
# Install rbenv
RUN apt autoremove -y ruby*  \
    && apt autoremove  \
    && apt update  \
    && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
    && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc  \
    && echo 'eval "$(rbenv init -)"' >> ~/.bashrc

ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH

# Install ruby-build & ruby
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build  \
    && ~/.rbenv/bin/rbenv install 2.6.0  \
    && ~/.rbenv/bin/rbenv global 2.6.0

# Initiarize ruby encording
ENV RUBYOPT -EUTF-8

# Install bundler
RUN ~/.rbenv/bin/rbenv exec gem install bundler
##############################################3

# Add the package keys.
# RUN apt-key adv --keyserver 'hkp://ha.pool.sks-keyservers.net:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
# Add ROS repository
RUN bash -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'  \
     && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654  \
    && apt-get update  \
    && apt-get install -f --fix-missing \
    && apt-get install -y --no-install-recommends \
    ros-kinetic-desktop-full \
    && rm -rf /var/lib/apt/lists/*

# Install ROS bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-rosinstall-generator \
    python-wstool

# Initialize 'rosdep'.
# http://wiki.ros.org/rosdep
# Set up rosdep
RUN rosdep init \
    && rosdep update

### Create catkin workspace ###
RUN mkdir -p /root/catkin_ws/src
RUN bash -c "source /opt/ros/kinetic/setup.bash  \
             && cd /root/catkin_ws \
             && catkin_make -DCMAKE_BUILD_TYPE=Release"

# Load ROS environment at docker exec bash
RUN bash -c 'echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc' \
    && bash -c 'echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc'
 
#############################################

# Python
RUN apt-get update  \
    && apt-get install -y python-dev \
    python-pip \
    python3-dev \
    python3-pip 
 
#update pip 
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python3 \
    && curl -kL https://bootstrap.pypa.io/get-pip.py | python

# Install pytho  dependencies
COPY ./requirements-python2.txt /root/
COPY ./requirements-python3.txt /root/

RUN  pip3 install -r /root/requirements-python3.txt \
    && pip2 install -r /root/requirements-python2.txt

#############################################
# Finally install some helpful tools
RUN apt-get update && \
    apt-get install -y vim \
    vim-gtk \ 
    xclip \
    openssh-server \
    tmux \
    graphviz \
    trash-cli \
    zsh \
    iputils-ping \
    net-tools \
    tree \
    xterm \
    lxterminal \
    libglew-dev \
    libxkbcommon-dev \
    && gem install --user-install tmuxinator bundler  \
    && apt install -f
#############################################

