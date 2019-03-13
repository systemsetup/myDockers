#!/bin/sh
# script for setting up docker based on ubuntu:16.04
# run this script after:
# sudo docker pull ubuntu:16.04
# sudo docker run -ti ubuntu:16.04 bash
# apt-get -qq update
# apt-get install -y git
# git clone https://github.com/systemsetup/myDockers.git
# cd docker-pyNNmoose 
# chmod +x base_install.sh
# bash base_install.sh
# NOTE: if you get an error redo "bash base_install.sh" [because of https://github.com/pypa/pip/issues/5240]

# Base installations
apt-get install -y wget bzip2 vim tmux lsof build-essential checkinstall libopenmpi-dev openmpi-bin openmpi-doc

## python-tk is for pylab, python-lxml libhdf5-serila-dev for NWB, python-all-dev cython for NEST
# for python2.7
apt-get install -y python2.7 python-pip python-tk python-lxml libhdf5-serial-dev python-all-dev cython
# for python3
apt-get install -y python3 python3-pip python3-tk python3-lxml libhdf5-serial-dev python3-dev cython3

# Install for NEURON
apt-get install -y libx11-dev libxext-dev mpich libncurses-dev

# Install for NEST
apt-get install -y cmake autoconf automake libtool libltdl7-dev libreadline6-dev libgsl0-dev gsl-bin

# Install for MOOSE
apt-get install -y pkg-config libgraphviz-dev libhdf5-dev

## Packges for setting virtual environments
# for python2.7
pip install --upgrade pip
pip install -U pip setuptools virtualenv
# for python3
pip3 install --upgrade pip setuptools virtualenv
