FROM yubaoliu/root:latest
MAINTAINER yubaoliu89@gmail.com

ENV PATH $PATH:/opt/ros/kinetic/bin
ENV PYTHONPATH $PYTHONPATH:/opt/ros/kinetic/lib/python2.7/dist-packages
ENV CMAKE_PREFIX_PATH $CMAKE_PREFIX_PATH:/opt/ros/kinetic

# setup environment
ENV ROS_DISTRO kinetic

# setup keys
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list



# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*


# bootstrap rosdep
RUN rosdep init \
    && rosdep update


RUN apt-get update &&  apt-get install -y \
    ros-kinetic-desktop-full  \
    ros-kinetic-robot \
    ros-kinetic-perception \
    python-rosinstall-generator  \
    ros-kinetic-catkin  \
    python-catkin-tools \
    ros-kinetic-geodesy \
    ros-kinetic-pcl-ros ros-kinetic-nmea-msgs ros-kinetic-libg2o && \
    echo "source /opt/ros/kinetic/setup.sh" >> /home/.bashrc && \
    rm -rf /var/lib/apt/lists/*

# GTSAM
RUN apt-get update && cd /tmp && \
    git clone https://github.com/borglab/gtsam.git && \
    cd gtsam && \
    mkdir build && \
    cd build && \
    cmake -DGTSAM_USE_QUATERNIONS=ON \
          -DGTSAM_BUILD_PYTHON=ON \
          -DGTSAM_ALLOW_DEPRECATED_SINCE_V4=OFF \
          .. && \
    make -j 2 && \
    make install && \
    rm -rf gtsam && \
    rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]

# clean
RUN apt-get autoremove  &&\
    rm -rf /var/lib/apt/lists/*
