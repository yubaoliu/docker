FROM ubuntu:xenial

MAINTAINER yubaoliu89@gmail.com

# Setup timezone
RUN echo 'Etc/UTC' > /etc/timezone && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update \
    && apt-get install -y tzdata


#####################TOOLS#########
RUN apt-get update && \
    apt-get install -y software-properties-common \
    sudo wget autoconf  \
    g++ freeglut3-dev build-essential libx11-dev \
    libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev

############# CUDA ################
# CUDA 10.2, https://developer.nvidia.com/cuda-10.2-download-archive?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=debnetwork
RUN wget -c  https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-ubuntu1604.pin \
    && mv cuda-ubuntu1604.pin /etc/apt/preferences.d/cuda-repository-pin-600 \
    && apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
    && add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/ /" \
    && apt-get update \
    && apt-get -y install cuda
#############CUDANN ################
