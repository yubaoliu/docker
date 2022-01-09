# FROM nvidia/cuda:11.4.2-cudnn8-devel-ubuntu18.04

FROM golang:1.12

COPY hosts /etc/hosts
# ENV http_proxy ${http_proxy}
# ENV https_proxy ${https_proxy}

RUN echo $http_proxy
RUN echo $https_proxy

RUN apt update \
    && apt install -y inetutils-ping  \
    curl \
    --fix-missing
 

# RUN apt update \
#     && apt install -y wget \
#     xterm \
#     inetutils-ping  \
#     curl \
#     --fix-missing
 
RUN curl www.google.com --max-time 3

# RUN cat /etc/hosts

# RUN ping raw.githubusercontent.com
 
# RUN wget -c https://raw.githubusercontent.com/ros/rosdistro/master/rosdep/sources.list.d/20-default.list


CMD ["bash"]
