# Mechanics of Running Docker.
The command
```
docker images
```
returns a list of available (local) images.

Running a docker image is like running the image as another image (which is called a container to avoid the confusion).
![Image and its container](images/mechanics_of_docker/mechanism_docker_image_run_container.png)

To run an image
![docker command to run](images/mechanics_of_docker/mechanism_docker_run_command.png)

## Tag of a docker image
Every image has a **tag** which by default is `latest`. An image with a number of tags can be thought of as different variants of the image.

## id of a docker image
An **id** of an image corresponds to a container of the image.

Thus,
- containers are created from images
- when you run an image, i.e., inside a container, and make changes like create files or install softwares, the changes will disappear if container after exit is not commited.

![Basic Docker Mechanics](images/mechanics_of_docker/mechanism_docker_ubuntu_example.png)

Note:
- for a list of **all containers**
```
docker ps -a
```
- for the **last** opened (exited) container
```
docker ps -l
```
- `docker commit <container_name> ubuntu:latest` updates the source image by writing over it.
- `docker commit <container_name> ubuntu:with_my_file` updates the source image by creating a new variant defined by its tag.
- `docker commit <container_name> changed_ubuntu` creates a new image based on the source image which has the tag `latest` by default.

