#!/bin/sh
# script for setting up docker based on ubuntu:16.04
# run this script after:
# sudo docker pull ubuntu:16.04
# sudo docker run -ti ubuntu:16.04 bash
# apt-get -qq update
# apt-get install -y git
# git clone https://github.com/systemsetup/myDockers.git
# cd 
# chmod +x base_install.sh
# bash base_install.sh

# Base installations
apt-get install -y wget bzip2 vim tmux build-essential checkinstall libopenmpi-dev openmpi-bin openmpi-doc python2.7 python-pip python-tk python-lxml libhdf5-serial-dev
# python-tk is for pylab and python-lxml libhdf5-serila-dev for NWB

# Install for NEURON
apt-get install -y libx11-dev libxext-dev mpich libncurses-dev

# Install for NEST
apt-get install -y cmake autoconf automake libtool libltdl7-dev libreadline6-dev libgsl0-dev gsl-bin python-all-dev cython

# Packges for setting virtual environments
pip install -U --upgrade pip
pip install -U pip setuptools
pip install -U virtualenv
