# This is an auto generated Dockerfile for ros:robot
# generated from docker_images/create_ros_image.Dockerfile.em
FROM ubuntu:16.04
MAINTAINER yubaoliu89@gmail.com

RUN apt-get update && apt-get install -y lsb-release \
    build-essential \
    git \
    vim \
    cmake \
    gcc g++ \
    python-wstool \
    libsuitesparse-dev

t config --global push.default simple

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
   apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116


# install ros packages
RUN apt-get update && apt-get install -y \
    ros-kinetic-desktop-full 


# config entrypoint
RUN echo "#!/bin/bash" >> /home/entrypoint.sh && \
    echo "source /opt/ros/kinetic/setup.bash" >> /home/entrypoint.sh && \
    echo "bash" >> /home/entrypoint.sh && \
    chmod 755 /home/entrypoint.sh
ENTRYPOINT ["/home/entrypoint.sh"]


# ROS Environment config
RUN rosdep init && rosdep update \
    mkdir /home/catkin_ws && cd /home/catkin_ws \
    && mkdir src/ && cd src/ && catkin_init_workspace


# clean
RUN rm -rf /var/lib/apt/lists/*




    