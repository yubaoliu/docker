build-ubuntu16-cuda11:
	docker-compose -f ./Ubuntu16/docker-compose.yml build
run-ubuntu16-cuda11:
	docker-compose -f ./Ubuntu16/docker-compose.yml down --remove-orphans \
	&& docker-compose -f ./Ubuntu16/docker-compose.yml up 

build-ubuntu18-cuda12:
	cd Extern/CMake && git checkout v3.18.1  && cd ../.. \
	&& cd Extern/Pangolin && git checkout master && cd ../.. \
	&& docker-compose -f ./Ubuntu18/docker-compose.yml build
run-ubuntu18-cuda12:
	docker-compose -f ./Ubuntu18/docker-compose.yml down &&  \
	docker-compose -f ./Ubuntu18/docker-compose.yml up --remove-orphans

build-ubuntu20-cuda12:
	cd Extern/CMake && git checkout v3.18.1  && cd ../.. \
	&& cd Extern/Pangolin && git checkout master && cd ../.. \
	&& docker-compose -f ./Ubuntu20/docker-compose.yml build
run-ubuntu20-cuda12:
	docker-compose  -f ./Ubuntu20/docker-compose.yml down \
	&& docker-compose -f ./Ubuntu20/docker-compose.yml up --remove-orphans

build-ubuntu24-cuda12:
	docker-compose -f ./Ubuntu24/docker-compose.yml build
run-ubuntu24-cuda12:
	docker-compose  -f ./Ubuntu24/docker-compose.yml down \
	&& docker-compose -f ./Ubuntu24/docker-compose.yml up --remove-orphans


build-calib:
	docker-compose -f ./CamLidarCalib/docker-compose.yml build
run-calib:
	docker-compose -f ./CamLidarCalib/docker-compose.yml down \
	&& docker-compose -f ./CamLidarCalib/docker-compose.yml up --remove-orphans

build-normal-usage:
	docker-compose -f ./NormalUsage/docker-compose.yml build
run-normal-usage:
	docker-compose -f ./NormalUsage/docker-compose.yml down \
	&& docker-compose -f ./NormalUsage/docker-compose.yml up --remove-orphans

# build-rplidar:
# 	docker-compose -f ./rplidar/docker-compose.yml build
# run-rplidar:
# 	docker-compose -f ./rplidar/docker-compose.yml down \
# 	&& docker-compose -f ./rplidar/docker-compose.yml up --remove-orphans

build-voxel-slam:
	docker-compose -f ./voxel-slam/docker-compose.yml build
run-voxel-slam:
	docker-compose -f ./voxel-slam/docker-compose.yml down  --remove-orphans \
	&& docker-compose -f ./voxel-slam/docker-compose.yml up
