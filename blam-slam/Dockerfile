FROM osrf/ros:kinetic-desktop-full
MAINTAINER Yubao <yubaoliu89@gmail.com>

# Install common packages
RUN apt-get update && apt-get install -y vim && \
	apt-get clean  && \
	rm -rf /var/lib/apt/lists/*

# ROS related
RUN apt-get update && apt-get install --no-install-recommends -y && apt-get install --no-install-recommends -y wget nano build-essential ros-kinetic-geodesy ros-kinetic-pcl-ros ros-kinetic-nmea-msgs ros-kinetic-rviz ros-kinetic-tf-conversions ros-kinetic-libg2o \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# GTSAM
RUN apt-get update && cd /tmp && \
    git clone https://github.com/borglab/gtsam.git && \
    cd gtsam && \
    mkdir build && \
    cd build && \
    cmake -DGTSAM_USE_QUATERNIONS=ON \
          -DGTSAM_BUILD_PYTHON=ON \
		  -DGTSAM_USE_SYSTEM_EIGEN=ON \
          -DGTSAM_ALLOW_DEPRECATED_SINCE_V4=OFF \
          .. && \
    make -j 2 && \
    make install && \
    rm -rf gtsam

# BLAM SLAM
RUN git clone https://github.com/yubaoliu/blam.git && \
	cd blam && \
	./update
	


#RUN sed -i "6i source \"/root/catkin_ws/devel/setup.bash\"" /ros_entrypoint.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#WORKDIR /

#ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
