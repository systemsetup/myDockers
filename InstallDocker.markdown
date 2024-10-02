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
If `docker version` does not work but `docker --version` works then do the following in its sequence
```
sudo services docker stop
sudo services docker start
sudo services start docker
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

**Additional step for Fedora 31**
```
sudo vi sudo gedit /etc/default/grub
```
Then append this `systemd.unified_cgroup_hierarchy=0` to `GRUB_CMDLINE_LINUX`.
Follow this with
```
sudo grub2-mkconfig
```
and reboot.

#### 2.2.1. Start Docker
Docker is installed but not started. That is, `docker` group is created but no users are added to the group.
```
sudo systemctl start docker
```

#### 2.2.2. Test installation
```
sudo docker run hello-world
```
If `docker version` does not work but `docker --version` works then do the following in its sequence
```
sudo services docker stop
sudo services docker start
sudo services start docker
```

### 2.3. Uninstall
```
sudo dnf remove docker-ce
sudo rm -rf /var/lib/docker
```

Source https://docs.docker.com/install/linux/docker-ce/fedora/

## 3. [For Fedora 32 onwards](https://fedoramagazine.org/docker-and-fedora-32)

This is a two stage process where you must first setup Docker repository and then install Docker from it.

If docker is alread installed remove it with the following commands
```
sudo dnf remove docker-*
sudo dnf config-manager --disable docker-*
```

### 3.1. Enable old CGroups
```
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
```

### 3.2. Whitelist docker in firewall
```
sudo firewall-cmd --permanent --zone=trusted --add-interface=docker0
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-masquerade
```

### 3.3. Install Moby and docker-compose
```
sudo dnf install moby-engine docker-compose"
```

#### 3.3.1. Enable Docker
```
sudo systemctl enable docker
```
NOTE: You might need to reboot the system `sudo systemctl reboot`.

## 4. For Windows

First download the stable `.exe` file

https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe

from https://store.docker.com/editions/community/docker-ce-desktop-windows


### 4.1. Install Docker CE
Double-click `Docker for Windows Installer.exe`


### 4.2. Start Docker
Double-click `Docker for Windows`. This should initiate a whale in the status bar.

### 4.3. Run Docker
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

### 1A.1.Setup Docker repository, then Install
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

### 1A.2. Uninstall
```
sudo apt-get remove docker docker-engine
sudo apt-get purge docker-ce
sudo rm -rf /var/lib/docker
```

Source https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04

## 5. Add user permission
First, add the user to the `docker` group
```
sudo groupadd docker
sudo usermod -aG docker <user-name>
```
Then, enter this group
```
newgrp docker
```
Now without sudo the `<user-name>` should be able to run `docker run hello-world`. Note that on reboot you should not need to type in the commands to enter `docker` group.
