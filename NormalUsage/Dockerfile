# This is an auto generated Dockerfile for ros:ros-core
# generated from docker_images/create_ros_core_image.Dockerfile.em
# Copyright (C) 2021, Yubao Liu, AISL, TOYOHASHI UNIVERSITY of TECHNOLOGY 
# Email: yubao.liu.ra@tut.jp 

FROM yubao/ubuntu20:cuda11.3.0
MAINTAINER yubao.liu.ra@tut.jp 

ENV DEBIAN_FRONTEND noninteractive

# WORKDIR /root

RUN wget -c https://download.zotero.org/client/release/7.0.13/Zotero-7.0.13_linux-x86_64.tar.bz2 \
    && tar -xvjf Zotero-7.0.13_linux-x86_64.tar.bz2 

# libs for zotero
RUN sudo apt update \
    && sudo apt-get install -y  libdbus-glib-1-2

RUN echo "alias zotero='/root/Zotero_linux-x86_64/zotero'" >> ~/.zshrc

# setup entrypoint
COPY NormalUsage/entrypoint.sh entrypoint.sh
RUN sudo chmod a+x entrypoint.sh
ENTRYPOINT ["/root/entrypoint.sh"]

CMD ["bash"]
