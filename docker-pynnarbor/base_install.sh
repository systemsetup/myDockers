#!/bin/sh
# script for setting up docker based on ubuntu:20.04
# run this script after:
# sudo docker pull ubuntu:20.04
# sudo docker run -ti ubuntu:20.04 bash
# apt-get -qq update
# apt-get install -y git
# git clone https://github.com/systemsetup/myDockers.git && cd myDockers/docker-pynnarbor 
# chmod +x base_install.sh
# bash base_install.sh
# NOTE: if you get an error redo "bash base_install.sh" [because of https://github.com/pypa/pip/issues/5240]

# Base installations
apt-get install -y wget bzip2 vim tmux tree lsof build-essential checkinstall libopenmpi-dev openmpi-bin openmpi-doc libhdf5-serial-dev
## python-tk is for pylab, python-lxml libhdf5-serila-dev for NWB, python-all-dev cython for NEST
apt-get install -y python3 python3-pip python3-tk python3-lxml python3-dev cython3;
pip3 install --upgrade pip setuptools virtualenv;;

# NOTE: python3.7-pip does not exist and python3-pip will install python3.6 the pip to it (confirmed using pip --version)
# if you really want python3.7 follow the steps below
#apt-get install curl
#curl https://bootstrap.pypa.io/get-pip.py | python3.7
# alternatively
#curl https://bootstrap.pypa.io/get-pip.py | sudo -H python3.7
# Source: https://askubuntu.com/questions/889535/how-to-install-pip-for-python-3.6-on-ubuntu-16-10
# See also: https://lxml.de/installation.html

# Install for NEURON
apt-get install -y libx11-dev libxext-dev mpich libncurses-dev

# Install for NEST
apt-get install -y cmake autoconf automake libtool libltdl7-dev libreadline6-dev libgsl0-dev gsl-bin

# Install for MOOSE
#apt-get install -y pkg-config libgraphviz-dev libhdf5-dev
