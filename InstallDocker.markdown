# Install and Setup for DockerCE (community edition)
Below are the installations steps/setup for Ubuntu, Fedora and Windows.

## 1. For Ubuntu

_If this does not work, see bottom for an alternative method_

First check your Ubuntu version
```
lsb_release -cs
```

This is a two stage process where you must first setup Docker repository and then install Docker from it.

### 1.1. Setup Docker repository
First
```
sudo apt-get update
sudo apt-get -y install apt-transport-https \
                        ca-certificates \
                        curl \
                        software-properties-common
```

Then sdd Docker's official GPG key
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Finally, setup appropriate Docker respository
```
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

### 1.2. Install Docker CE
```
sudo apt-get update
sudo apt-get -y install docker-ce
```

### 1.2.1. Start Docker
This step is usually not needed but following commands may come in handy
```
docker-machine start
docker-machine stop
docker-machine ip
docker-machine ssh
docker-machine scp
docker-machine upgrade
docker-machine restart
```

### 1.2.2. Test installation
```
sudo docker run hello-world
```

### 1.3. Uninstall
```
sudo apt-get purge docker-ce
sudo rm -rf /var/lib/docker
```

Source https://docs.docker.com/install/linux/docker-ce/ubuntu/


## 2. For Fedora

This is a two stage process where you must first setup Docker repository and then install Docker from it.

### 2.1. Setup Docker repository
First
```
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
```

### 2.2. Install Docker CE
```
sudo dnf install docker-ce
```
If asked to accept GPG key, verify that it matches `060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35`

### 2.2.1. Start Docker
Docker is installed but not started. That is, `docker` group is created but no users are added to the group.
```
sudo systemctl start docker
```

### 2.2.2. Test installation
```
sudo docker run hello-world
```

### 2.3. Uninstall
```
sudo dnf remove docker-ce
sudo rm -rf /var/lib/docker
```

Source https://docs.docker.com/install/linux/docker-ce/fedora/


## 3. For Windows

First download the stable `.exe` file

https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe

from https://store.docker.com/editions/community/docker-ce-desktop-windows


### 3.1. Install Docker CE
Double-click `Docker for Windows Installer.exe`


### 3.2. Start Docker
Double-click `Docker for Windows`. This should initiate a whale in the status bar.

### 3.3. Run Docker
Open PowerShell (my preferance)
```
docker version
docker run hello-world
```

Source https://docs.docker.com/docker-for-windows/install/


## 1A. For Ubuntu (alternative method)

_This is a method alternative to the official (above) one._

Check your Ubuntu version
```
lsb_release -cs
```

This is a two stage process where you must first setup Docker repository and then install Docker from it.

### 2A.1.Setup Docker repository, then Install
First
```
sudo apt-get update
sudo apt-key adv --keyserver \
                  hkp://p80.pool.sks-keyservers.net:80 \
                 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-add-repository \
    `deb https://apt.dockerproject.org/repo ubuntu-xenial main`
```

Then install
```
sudo apt-get update
apt-cache policy docker-engine
sudo apt-get install -y docker-engine
sudo systemctl status docker
```

### 2A.2. Uninstall
```
sudo apt-get remove docker docker-engine
sudo apt-get purge docker-ce
sudo rm -rf /var/lib/docker
```

Source https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04
