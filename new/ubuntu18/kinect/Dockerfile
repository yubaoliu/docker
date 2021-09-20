ARG CUDA_VERSION=10.2
FROM nvidia/cudagl:$CUDA_VERSION-devel-ubuntu18.04
LABEL maintainer "yubao <yubao.liu.ra@tut.jp>"

WORKDIR /root

# Setup timezone
RUN echo 'Asia/Tokyo' > /etc/timezone && \
    rm -f /etc/localtime && \
    # echo 'Etc/UTC' > /etc/timezone && \
    # ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apt-get update && apt-get install -y tzdata


RUN apt-get update && apt-get install -y --no-install-recommends \
   software-properties-common \
   cmake \
   sudo \
   cmake-qt-gui \
   git \
   libeigen3-dev \
   libjpeg-dev \
   libgl1-mesa-dev \
   libglew-dev \
   libsuitesparse-dev \
   libudev-dev \
   libusb-1.0-0-dev \
   libxkbcommon-x11-dev \
   openjdk-8-jdk \
   freeglut3-dev \
   zlib1g-dev \
   libturbojpeg \
   libjpeg-turbo8-dev \
   libturbojpeg0-dev \
   cuda-samples-10-2 \
   && rm -rf /var/lib/apt/lists/*

# Add ROS repository
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
# Keys for ROS repository
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654  \
# Install ROS-Base packages
    && apt-get update && apt-get install --no-install-recommends -y \
    ros-melodic-desktop-full \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-rosinstall-generator \
    python-wstool \
    && rosdep init \
    && rosdep update

### Create catkin workspace ###
RUN mkdir -p /root/catkin_ws/src
WORKDIR /root/catkin_ws
RUN bash -c "source /opt/ros/melodic/setup.bash && \
             catkin_make -DCMAKE_BUILD_TYPE=Release"

# Load ROS environment at docker exec bash
RUN echo "source /opt/ros/melodic/setup.bash" >> /root/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
 
# RUN cd ~/catkin_ws/src/ \
#     && git clone https://github.com/code-iai/iai_kinect2.git \
#     && cd iai_kinect2 \
#     && rosdep install -r --from-paths . \
#     && cd ~/catkin_ws \
#     && /bin/bash -c "source /opt/ros/melodic/setup.bash" \
#     && catkin_make -DCMAKE_BUILD_TYPE="Release"

# OpenNI2
RUN apt-get update && apt-get install -y --no-install-recommends \
   libopenni2-dev \
   libopenni2-0 \
   openni2-utils  \
   openni2-doc \
   && rm -rf /var/lib/apt/lists/*

# kinect2, https://www.cnblogs.com/panandying/p/10656234.html
RUN git clone https://github.com/OpenKinect/libfreenect2.git \
    && cd libfreenect2 \
    && mkdir build \
    && cd build \
    #&& cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/freenect2 \
    && cmake .. \
    && make \
    && make install \
    && make install-openni2 \
    && cp ../platform/linux/udev/90-kinect2.rules /lib/udev/rules.d/  \
    && ldconfig
# test kinect2 using NiViewer2 

# Install Realsense
RUN apt update \
    && apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE \
    && add-apt-repository -y "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    librealsense2-dkms \
    librealsense2-dev \
    librealsense2-utils


RUN apt update  \
    && apt install -y xterm \
    lxterminal \
    vim

WORKDIR /root
