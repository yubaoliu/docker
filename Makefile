CUDA=cuda8

#ROOT
ROOT_NAME=yubaoliu/root
ROOT_VERSION=$(CUDA)
ROOT_CONTAINER_NAME=root-cuda8

build-root:
	docker build -t $(ROOT_NAME):$(ROOT_VERSION) root

tart-root:
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


#ROS
ROS_NAME=yubaoliu/ros-kinetic
ROS_VERSION=$(CUDA)
ROS_CONTAINER_NAME=ros-cuda8


build-ros:
	docker build -t $(ROS_NAME):$(ROS_VERSION) ros-kinetic

run-ros:
	docker run -it \
	--net host \
	-e DISPLAY=$$DISPLAY \
	-v $$HOME/.Xauthority:/root/.Xauthority \
	-v /home/yubao/data/share/docker-ros:/home \
	--runtime=nvidia \
	--name $(ROS_CONTAINER_NAME) \
	$(ROS_NAME):$(ROS_VERSION)

#blam-slam
BLAM_NAME=yubaoliu/blam-slam
BLAM_VERSION=$(CUDA)
BLAM_CONTAINER_NAME=blam-slam


build-blam:
	docker build -t $(ROS_NAME):$(BLAM_VERSION) blam-slam

run-ros:
	docker run -it \
	--net host \
	-e DISPLAY=$$DISPLAY \
	-v $$HOME/.Xauthority:/root/.Xauthority \
	-v /home/yubao/data/share/docker-ros:/home \
	--runtime=nvidia \
	--name $(BLAM_CONTAINER_NAME) \
	$(BLAM_NAME):$(BLAM_VERSION)




clean:
	@if [ "$(image)" != "" ] ; then \
		docker rmi $(image); \
	fi
	@if [ "$(contener)" != "" ] ; then \
		docker rm $(contener); \
	fi

