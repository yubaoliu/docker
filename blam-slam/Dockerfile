# This is an auto generated Dockerfile for ros:robot
# generated from docker_images/create_ros_image.Dockerfile.em
FROM yubaoliu/ros-kinetic:cuda8
MAINTAINER yubaoliu89@gmail.com

RUN apt-get update && apt-get install -y --fix-missing && apt-get upgrade 

# config entrypoint
RUN rm -rf /home/entrypoint.sh && \ 
    echo "#!/bin/bash" >> /home/entrypoint.sh && \
    echo "echo \"This is entrypoint\"" >> /home/entrypoint.sh && \
    echo "bash" >> /home/entrypoint.sh && \
    chmod 755 /home/entrypoint.sh 

#blam slam
RUN cd /home && \
    git clone https://github.com/yubaoliu/blam.git && \
    cd blam && \
    ./update && \
    source /home/catkin_ws/devel/setup.sh

CMD ["/bin/bash"]
ENTRYPOINT ["/home/entrypoint.sh"]

WORKDIR /home

# clean
RUN apt-get autoremove  &&\
    rm -rf /var/lib/apt/lists/*




    
