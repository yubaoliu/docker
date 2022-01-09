

# Enable display

```sh
xhost +local:root
```

# Release 

- FROM yubao/ubuntu20:cuda11
- FROM yubao/ubuntu18:cuda11
- FROM yubao/ubuntu16:cuda11

# Root

## Image

- image: yubaoliu/root:ros-cuda10.2-cudnn7-ubuntu18
- image: yubaoliu/root:ros-cuda10.2-cudnn7-ubuntu16

## Test root image

```sh
docker-compose -f docker-compose-test-ubuntu18.yml up
```

# Tips

If you encounter very wired probems, prune images, volums and containers.


For exame, I use ``git clone`` within my image. However, it did not appear in my image.


In this case:
- Remove all containers
- Remove all volums 
- Remove all docker-compose services


# Notice
- Cannot use private git repo in docker file
- Cannot use ssh to git clone repo in dockerfile


# TODO
- 为了节省存储空间，分层管理dockerfile
