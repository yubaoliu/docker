# waleedka/modern-deep-learning

-   [waleedka/modern-deep-learning](https://hub.docker.com/r/waleedka/modern-deep-learning)

## Docker Pull Command

```sh
docker pull waleedka/modern-deep-learning
```

## Runing the Docker Image

```sh
docker run -it -p 8888:8888 -p 6006:6006 -v ~/:/host waleedka/modern-deep-learning
```

## Running Jupyter Notebook

While inside the Docker container (see previous section) run this command, then navigate to: <http://localhost:8888/>

```sh
cd /host    # So Jupyter Notebook uses this as it's root
jupyter notebook --allow-root
```

Alternatively, combine the previous two steps and start Jupyter Notebook without logging into the container:

```sh
docker run -it -p 8888:8888 -p 6006:6006 -v ~/:/host waleedka/modern-deep-learning jupyter notebook --allow-root /host
```
