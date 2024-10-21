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
apt install -y wget bzip2 vim tmux tree lsof build-essential checkinstall libopenmpi-dev openmpi-bin openmpi-doc libhdf5-serial-dev
## python-tk is for pylab, python-lxml libhdf5-serila-dev for NWB, python-all-dev cython for NEST
apt install -y python3 python3-pip python3-setuptools python3-virtualenv python3-tk python3-lxml python3-dev cython3
apt install --upgrade pip

# Check installed version
apt list python3

# Install for ANNarchy
