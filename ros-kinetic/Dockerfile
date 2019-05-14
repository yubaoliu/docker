# This is an auto generated Dockerfile for ros:robot
# generated from docker_images/create_ros_image.Dockerfile.em
FROM ubuntu:16.04
MAINTAINER yubaoliu89@gmail.com

SHELL ["/bin/bash", "-c"]

ENV PATH $PATH:/opt/ros/kinetic/bin
ENV PYTHONPATH $PYTHONPATH:/opt/ros/kinetic/lib/python2.7/dist-packages

RUN apt-get update && apt-get install -y lsb-release \
    build-essential \
    bash-completion \
    curl \
    wget \
    git \
    vim \
    cmake \
    gcc g++ \
    python-wstool \
    libsuitesparse-dev

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
   apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116


# install ros packages
RUN apt-get update && apt-get install -y \
    ros-kinetic-desktop-full  \
    python-rosinstall python-rosinstall-generator python-wstool build-essential \
    ros-kinetic-catkin python-catkin-tools \
    ros-kinetic-geodesy ros-kinetic-pcl-ros ros-kinetic-nmea-msgs ros-kinetic-libg2o


# config entrypoint
RUN echo "#!/bin/bash" >> /home/entrypoint.sh && \
    echo "echo \"This is entrypoint\"" >> /home/entrypoint.sh && \
    echo "bash" >> /home/entrypoint.sh && \
    chmod 755 /home/entrypoint.sh 


# ROS Environment config
RUN rosdep init && \
    rosdep update && \
    mkdir -p /home/catkin_ws/src && \
    cd /home/catkin_ws/src && \
    catkin_init_workspace && \
    echo "source /opt/ros/kinetic/setup.bash" >> /root/.bashrc && \
    echo "source /home/catkin_ws/devel/setup.bash" >> /root/.bashrc && \
    source /root/.bashrc

CMD ["/bin/bash"]
ENTRYPOINT ["/home/entrypoint.sh"]

WORKDIR /home

# clean
RUN apt-get autoremove  &&\
    rm -rf /var/lib/apt/lists/*




    