# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
FROM nvidia/cudagl:11.3.1-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive

# setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -q -y --no-install-recommends tzdata && \
    rm -rf /var/lib/apt/lists/*

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO noetic

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

#------------ Install ROS ---------------
# RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list'
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 \
    && apt-get update \
    && apt-get install --no-install-recommends -y  ros-noetic-desktop-full \
    python3-rosdep \
    python3-rosinstall  \
    && rosdep init \
    && rosdep update \
    && mkdir -p /root/catkin_ws/src \
    && bash -c "source /opt/ros/noetic/setup.bash \
            && cd /root/catkin_ws \
            && catkin_make -DCMAKE_BUILD_TYPE=Release" \
    && echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc \
    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc

# Install tools for development
RUN apt-get update && \
    apt-get install -y lxterminal vim tmux

# # install ros packages
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     ros-melodic-ros-core=1.4.1-0* \
#     && rm -rf /var/lib/apt/lists/*
# 
# # setup entrypoint
# COPY ./ros_entrypoint.sh /

# ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
