# Quick start guide to  Docker commands
Assuming that you have docker images collected using `docker pull <image_name>:<its_tag>`

## 1. Running an image
### 1.1. Running in current console window, i.e., interactive mode.
```
docker run -ti <image_name>:<its_tag> bash
```
NOTE: If you don't type in its tag, the `latest` tag/variant of the image will be chosen by default.

### 1.2. Running in the background of the console, i.e., detached mode.
```
docker run -d <image_name>:<its_tag> bash
```
To interact with this you must attach it.

#### 1.2.1. Attaching a running container
```
docker attach <container_name>
```
You can obtain container_name from `docker ps`.

#### 1.2.2. Adding another process to a _running_ container
```
docker exec -ti <container_name> bash
```
Then say you typed `touch foo`, the command `ls` should return the filename "foo" in the running container.

### 1.3. Special cases of running an image
#### 1.3.1. Serial processing
```
docker run -ti <image_name>:<its_tag> bash -c "sleep 3; echo all done"
```

#### 1.3.2. Run jupyter notebook (default port)
```
docker run -ti -p 8888:8888 <image_name>:<its_tag> bash
```

#### 1.3.3. Misch.
```
docker run --cpu-shares
```
and
```
docker run --memory maximum-allowed-memory <image_name> command
```

## 2. Coming out of a docker container
### 2.1. Exit
**Ctrl + D**
### 2.2. Out of the container but still running in background
**Ctrl + P** then **Ctrl + Q**
### 2.3. Exit from container that is running in the background
```
docker kill <container_name>
```

## 3. List docker containers that you have opened
### 3.1. Get the last container
```
docker ps -l
```
alternatively,
```
docker ps --latest
```
### 3.2. Get all the containers you ran
```
docker ps -a
```
alternatively,
 ```
 docker ps --all
 ```
 
 ## 4. Removing an image or container
 I prefer using
 ```
 docker rmi --force <image_name>
 ```
 It should be noted that it is fairly common for the image to be deleted but a mirror of the image may remain. This remaining image does not usually have the same name but using IMAGE ID it can be removed.
 ```
 docker rmi --force <IMAGE ID>
 ```
 Below are some other commands
 - `docker rm <container_name>`
 - `docker rmi $(docker images <image_name>:<its_tag>)`
 - `docker rm $(docker ps -a -q)` to remove all containers.

