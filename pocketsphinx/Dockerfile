FROM  ros:indigo-robot
MAINTAINER Yubao <yubaoliu89@gmail.com>

RUN apt upgrade && \
	apt-get install -y vim && \
	python-pip && \
	gcc && \
	automake && \
	autoconf && \
	libtool && \
	swig && \
	python3-dev && \
	python3-numpy && \
	python3-scipy && \
	sox && \
	bison && \
	libgtk-3-dev && \
	libgtk3*

	

RUN apt upgrade && \
	apt-get install -y 	gstreamer0.10-pocketsphinx && \
	ros-indigo-pocketsphinx && \
	ros-indigo-audio-common && \
	libasound2 && \
	gstreamer0.10-gconf && \
	apt-get clean && \
 	rm -rf /var/lib/apt/lists/*

CMD ["bash"]
	


