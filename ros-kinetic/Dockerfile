
FROM yubaoliu/root:cuda8
MAINTAINER yubaoliu89@gmail.com

SHELL ["/bin/bash", "-c"]
ENV PATH $PATH:/opt/ros/kinetic/bin
ENV PYTHONPATH $PYTHONPATH:/opt/ros/kinetic/lib/python2.7/dist-packages
ENV CMAKE_PREFIX_PATH $CMAKE_PREFIX_PATH:/opt/ros/kinetic
ENV GIT_SSL_NO_VERIFY 1


RUN apt-get update && apt-get install -y --fix-missing \
    && rm -rf /var/lib/apt/lists/*

# install ros packages
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
   apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt-get update && apt-get -y  upgrade &&  apt-get install -y \
    ros-kinetic-desktop-full  \
    python-rosinstall python-rosinstall-generator  \
    ros-kinetic-catkin python-catkin-tools \
    ros-kinetic-geodesy ros-kinetic-pcl-ros ros-kinetic-nmea-msgs ros-kinetic-libg2o \
    && rm -rf /var/lib/apt/lists/*


# ROS Environment config
RUN rosdep init && \
    rosdep update && \
    mkdir -p /home/catkin_ws/src && \
    cd /home/catkin_ws/src && \
    catkin_init_workspace && \
    echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc && \
    source /root/.bashrc && \
    cd /home/catkin_ws  && \
    catkin_make && \
    echo "source /home/catkin_ws/devel/setup.bash" >> /root/.bashrc

# GTSAM
RUN cd /tmp && \
    git clone https://bitbucket.org/gtborg/gtsam.git && \
    cd gtsam && \
    mkdir build && \
    cd build && \
    cmake -DGTSAM_USE_QUATERNIONS=ON \
          -DGTSAM_BUILD_PYTHON=ON \
          -DGTSAM_ALLOW_DEPRECATED_SINCE_V4=OFF \
          .. && \
    make  && \
    make install && \
    rm -rf gtsam

CMD ["/bin/bash"]

