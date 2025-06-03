
# Requirements
- docker
- docker-compose
- NVIDIA Container Toolkit

# Usage
- Get dependences
```sh
./get_dependences.sh
```
# Enable display

```sh
xhost +local:root
```

# Examples
- Test nvidia

    ```sh
    docker run --runtime=nvidia --rm nvidia/cudagl:11.3.0-devel-ubuntu20.04  nvidia-smi
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


# Refefences
- [Installing the NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
- [CUDA GPU Compute Capability](https://developer.nvidia.com/cuda-gpus)

# TODO
- 为了节省存储空间，分层管理dockerfile


