ARG CUDA_VERSION
ARG CUDNN_VERSION

# FROM nvidia/cuda:${CUDA_VERSION}-${CUDNN_VERSION}-devel-ubuntu16.04
FROM ros:kinetic-perception as ros-kinetic
FROM nvidia/cudagl:${CUDA_VERSION}-devel-ubuntu16.04
MAINTAINER yubao.liu.ra@tut.jp 

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root


RUN apt update \
    && apt install -y xterm

COPY --from=ros-kinetic /opt/ros /opt/ros

# Install ROS bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    python-rosinstall-generator \
    python-wstool \
    --fix-missing \
    && rm -rf /var/lib/apt/lists/*


CMD ["bash"]
