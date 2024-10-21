#!/bin/sh
# script for setting up docker based on ubuntu:20.04
# run this script after:
# base_install.sh
# to run this script
# chmod +x env_install.sh
# bash env_install.sh

# Create environment for python3
virtualenv -p /usr/bin/python3 /envs/annarchy4.8.1
source /envs/annarchy4.8.1/bin/activate

# Required packages https://annarchy.github.io/Installation.html
pip install "numpy>=1.21" "sympy>=1.11" "scipy>=1.9" "matplotlib>=3.0" "tqdm>=4.60"

# Check installed versions
pip freeze | grep numpy && pip freeze | grep sympy && pip freeze | grep scipy && pip freeze | grep matplotlib && pip freeze | grep tqdm

# Also install recommended packages
pip install lxml pandoc tensorflow tensorboardX

# Install stable version of ANNarchy
pip install ANNarchy
# should be same as installing from the master branch https://annarchy.github.io/Installation.html#using-pip
# pip install git+https://github.com/ANNarchy/ANNarchy.git@master

# Additional packages that can come handy
pip install -U Sphinx pandas mpi4py ipython jupyter quantities neo elephant pynwb bokeh pyneuroml nose nineml
pip install dask distributed --upgrade

# Deactivate the activated virtualenv once python related packages are installed
deactivate
