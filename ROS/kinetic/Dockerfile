# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
FROM ubuntu:xenial

# setup environment
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV ROS_DISTRO kinetic

# Install tools for development
RUN apt-get update && \
    apt-get install -y software-properties-common  --no-install-recommends \
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

# Python
RUN apt-get update  \
    && apt-get install -y python-dev \
    python-pip \
    python3-dev \
    python3-pip 
 
#update pip 
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python3 \
    && curl -kL https://bootstrap.pypa.io/get-pip.py | python


# Install rbenv
RUN apt autoremove -y ruby*  \
    && apt autoremove \
    && apt update  \
    && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
    && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc \
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


# Add ROS repository
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'  \
    && apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654  \
    && apt-get update  \
    && apt-get install -f \
    && apt-get install -y ros-kinetic-desktop-full \
    && rm -rf /var/lib/apt/lists/*

# Install ROS bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-rosinstall-generator \
    python-wstool \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO

### Create catkin workspace ###
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws
RUN bash -c "source /opt/ros/kinetic/setup.bash && \
             catkin_make -DCMAKE_BUILD_TYPE=Release"

# Load ROS environment at docker exec bash
RUN echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc  \
    && echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
 
# Finally install some helpful tools
RUN apt-get update && \
    apt-get install -y vim \
    vim-gtk \ 
    xclip \
    openssh-server \
    tmux \
    trash-cli \
    zsh \
    iputils-ping \
    net-tools \
    tree \
    xterm \
    lxterminal \
    libglew-dev \
    libxkbcommon-dev \
    mesa-utils \
    libglu1-mesa-dev freeglut3-dev mesa-common-dev \
    pciutils \
    pacman \
    && gem install --user-install tmuxinator bundler  \
    && apt install -f \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
