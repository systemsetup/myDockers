# Quick start guide to  Docker commands
## 1. Setting up docker for user
This step will not be needed if you run docker as `root`, i.e, `sudo docker <commands>`. However, for security it is not recommended.

Get the list of users
```
who -u
```
or just
```
who
```
However, if you have logged in as a user (not as `root`) but unsure of your `<username>` in the system
```
whoami
```
will return the `<username>`. To logout `sudo pkill -KILL -u <username>` or `sudo pkill -9 -u <username>`.

To run docker commands without the prefix `sudo` do

- Debian based
```
sudo usermod -aG docker <username>
```
- Fedora
```
sudo groupadd docker
sudo gpasswd -a ${USER}
```

Finally, assuming that you have docker images collected using `docker pull <image_name>:<its_tag>`

## 2. Running an image
### 2.1. Running in current console window, i.e., interactive mode.
```
docker run -ti <image_name>:<its_tag> bash
```
NOTE: If you don't type in its tag, the `latest` tag/variant of the image will be chosen by default.

### 2.2. Running in the background of the console, i.e., detached mode.
```
docker run -d <image_name>:<its_tag> bash
```
To interact with this you must attach it.

#### 2.2.1. Attaching a running container
```
docker attach <container_name>
```
You can obtain container_name from `docker ps`.

#### 2.2.2. Adding another process to a running container
```
docker exec -ti <container_name> bash
```
Then say you typed `touch foo`, the command `ls` should return the filename "foo" in the running container.

### 2.3. Special cases of running an image
#### 2.3.1. Run container sharing with a desired local directory
```
docker run -ti -v /path/to/local/directory:/path/to/container/directory <image_name>:<its_tag> bash
```
You will be in the root directory of the container. However if you want it to be `/path/to/container/directory` then
```
docker run -ti -v /path/to/local/directory:/path/to/container/directory \
               -w /path/to/container/directory \
               <image_name>:<its_tag> bash
```

#### 2.3.2. Run jupyter notebook (default port)
```
docker run -ti -p 8888:8888 <image_name>:<its_tag> bash
```
or
```
docker run -ti -p 8888:8888 \
               -v /path/to/local/directory:/path/to/container/directory \
               <image_name>:<its_tag> bash
```
or
```
docker run -ti -p 8888:8888 \
               -v /path/to/local/directory:/path/to/container/directory \
               -w /path/to/container/directory \
               <image_name>:<its_tag> bash
```

#### 2.3.3. Run Bokeh (default port)
```
docker run -ti -p 5006:5006 \
               -v /path/to/local/directory:/path/to/container/directory \
               -w /path/to/container/directory \
               <image_name>:<its_tag> bash
```

#### 2.3.4. Serial processing
```
docker run -ti <image_name>:<its_tag> bash -c "sleep 3; echo all done"
```

#### 2.3.4. Misch.
```
docker run --cpu-shares
```
and
```
docker run --memory maximum-allowed-memory <image_name> command
```

## 3. Coming out of a docker container
### 3.1. Exit
**Ctrl + D**
### 3.2. Out of the container but still running in background
**Ctrl + P** then **Ctrl + Q**
### 3.3. Exit from container that is running in the background
```
docker kill <container_name>
```

## 4. List docker containers that you have opened
### 4.1. Get the last container
```
docker ps -l
```
alternatively,
```
docker ps --latest
```
### 4.2. Get all the containers you ran
```
docker ps -a
```
alternatively,
 ```
 docker ps --all
 ```
 
 ## 5. Removing an image or container
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

