# This is an auto generated Dockerfile for ros:robot
# generated from docker_images/create_ros_image.Dockerfile.em
FROM yubaoliu/ros-kinetic
MAINTAINER yubaoliu89@gmail.com

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y --fix-missing --no-install-recommends 

# config entrypoint
RUN echo "#!/bin/bash" >> /home/entrypoint.sh && \
    echo "echo \"This is entrypoint\"" >> /home/entrypoint.sh && \
    echo "bash" >> /home/entrypoint.sh && \
    chmod 755 /home/entrypoint.sh 

#blam slam
WORKDIR /home/catkin_ws/src
RUN git clone https://github.com/erik-nelson/blam.git && \
    cd blam && \
    ./update

CMD ["/bin/bash"]
ENTRYPOINT ["/home/entrypoint.sh"]

WORKDIR /home

# clean
RUN apt-get autoremove  &&\
    rm -rf /var/lib/apt/lists/*




    