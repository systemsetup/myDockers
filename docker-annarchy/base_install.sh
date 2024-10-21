#!/bin/sh
# script for setting up docker based on ubuntu:24.10
# run this script after:
# docker pull ubuntu:24.10
# docker run -ti ubuntu:24.10 bash
# apt -qq update
# apt install -y git
# git clone https://github.com/systemsetup/myDockers.git && cd myDockers/docker-annarchy 
# chmod +x base_install.sh
# bash base_install.sh
# NOTE: if you get an error redo "bash base_install.sh" [because of https://github.com/pypa/pip/issues/5240]

# Base installations
apt install -y wget bzip2 vim tmux tree lsof checkinstall libopenmpi-dev openmpi-bin openmpi-doc libhdf5-serial-dev

# Install for ANNarchy
apt install -y build-essential clang python3 python3-pip python3-setuptools python3-virtualenv python3-tk python3-lxml python3-dev cython3
apt install --upgrade pip

# Check installed version
apt list python3 g++ gcc clang make python3-setuptools cython3
# alternatively
# apt show python3 g++ gcc clang make python3-setuptools cython3

#gcc --version
#clang --version

# Function to check versions: https://unix.stackexchange.com/a/567537
version_greater_equal()
{
    printf '%s\n%s\n' "$2" "$1" | sort --check=quiet --version-sort
}

# gcc --version && version_greater_equal "${gcc_version}" 7.4 || echo "need 7.4 or above" && echo "upgrade" && apt install -y --upgrade gcc
