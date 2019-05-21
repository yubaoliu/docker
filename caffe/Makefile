build-cup:
	docker build -t yubaoliu/caffe:cpu cpu
build-gpu:
	docker build -t yubaoliu/caffe:gpu gpu
runtest:
	docker run -ti yubaoliu/caffe:cpu bash -c "cd /opt/caffe/build; make runtest"
