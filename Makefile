build-ubuntu16-cuda11:
	docker-compose -f ./Ubuntu16/docker-compose.yml build
run-ubuntu16-cuda11:
	docker-compose -f ./Ubuntu16/docker-compose.yml up --remove-orphans

build-ubuntu18-cuda11:
	cd Extern/CMake && git checkout v3.18.1  && cd ../.. \
	&& cd Extern/Pangolin && git checkout master && cd ../.. \
	&& docker-compose -f ./Ubuntu18/docker-compose.yml build
run-ubuntu18-cuda11:
	docker-compose -f ./Ubuntu18/docker-compose.yml up --remove-orphans

build-ubuntu20-cuda11:
	cd Extern/CMake && git checkout v3.18.1  && cd ../.. \
	&& cd Extern/Pangolin && git checkout master && cd ../.. \
	&& docker-compose -f ./Ubuntu20/docker-compose.yml build
run-ubuntu20-cuda11:
	docker-compose  -f ./Ubuntu20/docker-compose.yml down \
	&& docker-compose -f ./Ubuntu20/docker-compose.yml up --remove-orphans

build-calib:
	docker-compose -f ./CamLaserCalibration/docker-compose.yml build
run-calib:
	docker-compose -f ./CamLaserCalibration/docker-compose.yml down \
	&& docker-compose -f ./CamLaserCalibration/docker-compose.yml up --remove-orphans

	# cd Extern/CMake && git checkout v3.18.1 && cd ../.. \
	# && cd Extern/Pangolin && git checkout v0.6 && cd ../.. \
