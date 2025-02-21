# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
# Copyright (C) 2021, Yubao Liu, AISL, TOYOHASHI UNIVERSITY of TECHNOLOGY 
# Email: yubao.liu.ra@tut.jp 

FROM yubao/ubuntu18:cuda11.3.0
MAINTAINER yubao.liu.ra@tut.jp 

ENV DEBIAN_FRONTEND noninteractive

# WORKDIR /root

# pepperl_fuchs lidar Driver
RUN cd catkin_ws/src \
    && git clone https://github.com/dillenberger/pepperl_fuchs.git
    
# CamLaserCalibrationTool
RUN cd catkin_ws/src \
    && git clone https://github.com/MegviiRobot/CamLaserCalibraTool

# https://github.com/acfr/cam_lidar_calibration
RUN sudo apt update \
    && sudo apt-get install -y ros-melodic-pcl-conversions ros-melodic-pcl-ros ros-melodic-tf2-sensor-msgs \
    && cd catkin_ws/src \
    && git clone https://github.com/acfr/cam_lidar_calibration.git

# RUN cd LaserCameraCal_ws \
#     && catkin_make -DCMAKE_BUILD_TYPE=Release

# setup entrypoint
COPY CamLaserCalibration/entrypoint.sh entrypoint.sh
RUN sudo chmod a+x entrypoint.sh
ENTRYPOINT ["/home/ubuntu/entrypoint.sh"]

CMD ["bash"]
