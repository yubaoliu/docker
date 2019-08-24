CUDA=cuda8
CUDANN_VERSION=cudnn6

#ROOT
ROOT_NAME=yubaoliu/root
ROOT_VERSION=latest
ROOT_CONTAINER_NAME=root-ubuntu1604

#ROOT-CUDA
ROOT_CUDA_NAME=yubaoliu/root-cuda
ROOT_CUDA_VERSION=$(CUDA)
ROOT_CUDA_CONTAINER_NAME=root-$(CUDA)

#ROS
ROS_NAME=yubaoliu/ros-kinetic
ROS_VERSION=latest
ROS_CONTAINER_NAME=ros-kinetic



build-root:
	docker build -t $(ROOT_NAME):$(ROOT_VERSION) root

build-root-cuda:
	nvidia-docker build -t $(ROOT_CUDA_NAME):$(ROOT_CUDA_VERSION)-$(CUDANN_VERSION)  . -f root/Dockerfile_$(CUDA)-$(CUDANN_VERSION)

build-blam:
	nvidia-docker build -t blam -f blam-slam/Dockerfile .

run-blam:
	docker run -it --rm \
	--net host \
	-e DISPLAY=$$DISPLAY \
	-v $$HOME/.Xauthority:/root/.Xauthority \
	-v /home/yubao/data/share/blam:/root/catkin_ws/src \
	--name blam  \
	blam


build-ros-melodic:
	nvidia-docker build -t ros-melodic -f ros/melodic/Dockerfile .

run-ros-melodic:
	docker run -it \
	--net host \
	-e DISPLAY=$$DISPLAY \
	-v $$HOME/.Xauthority:/root/.Xauthority \
	-v /home/yubao/data/share/melodic:/root/catkin_ws/src \
	--runtime=nvidia \
    --rm \
	--name ros-melodic  \
	ros-melodic


build-ros-kinetic:
	docker build -t $(ROS_NAME):$(ROS_VERSION) ros/kinetic

clean:
	docker rmi -f yubaoliu/ros-kinetic:$(ROS_VERSION)
	docker rmi -f yubaoliu/root:$(ROOT_VERSION)

pull:
	docker rmi -f yubaoliu/ros-kinetic:$(ROS_VERSION)
	docker rmi -f yubaoliu/root:$(ROOT_VERSION)


start-root:
	docker start $(ROOT_CONTAINER_NAME)

run-root:
	docker run -it \
	--net host \
	-e DISPLAY=$$DISPLAY \
	-v $$HOME/.Xauthority:/root/.Xauthority \
	-v /home/yubao/data/share/docker-ros:/home \
	--runtime=nvidia \
	--name $(ROOT_CONTAINER_NAME) \
	$(ROOT_NAME):$(ROOT_VERSION)

run-cuda:
	docker run -it \
	--net host \
	-e DISPLAY=$$DISPLAY \
	-v $$HOME/.Xauthority:/root/.Xauthority \
	-v /home/yubao/data/share/docker-ros:/home \
	--runtime=nvidia \
	--name $(CUDA_VERSION)$(CUDANN_VERSION) \
	$(ROOT_CUDA_NAME):$(ROOT_CUDA_VERSION)-$(CUDANN_VERSION) \
	bash



contener=`docker ps -a -q`
image=`docker images | awk '/^<none>/ { print $$3 }'`

stop-root:
	docker stop -f $(ROOT_CONTAINER_NAME)

exec-root:
	docker exec -it $(ROOT_CONTAINER_NAME) /bin/bash

logs-root:
	docker logs $(ROOT_CONTAINER_NAME)

rm-root:
	docker rm $(ROOT_CONTAINER_NAME)

run-ros:
	docker run -it \
	--net host \
	-e DISPLAY=$$DISPLAY \
	-v $$HOME/.Xauthority:/root/.Xauthority \
	-v /home/yubao/data/share/docker-ros:/home/balm \
	--runtime=nvidia \
	--name $(ROS_CONTAINER_NAME) \
	$(ROS_NAME):$(ROS_VERSION)

remove-none-images:
	docker images|grep "none"|awk '{print $$3 }'|xargs docker rmi -f
