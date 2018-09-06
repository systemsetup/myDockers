#!/bin/sh
# script for setting up docker based on ubuntu:16.04
# run this script after:
# base_install.sh
# to run this script
# chmod +x py27_install.sh
# py27_install.sh

# Create environment for python2.7
virtualenv -p /usr/bin/python2.7 /envs/py27-cerebunit
source /envs/py27-cerebunit/bin/activate

# Setup environment
pip install -U numpy scipy matplotlib pandas mpi4py ipython jupyter quantities neo elephant pynwb sciunit bokeh
pip install dask distributed --upgrade

mkdir simulators && cd simulators

############################### NEURON ##################################
# Install NEURON setup
mkdir neuron7.5 && cd neuron7.5
wget "http://www.neuron.yale.edu/ftp/neuron/versions/v7.5/nrn-7.5.tar.gz"
wget "http://www.neuron.yale.edu/ftp/neuron/versions/v7.5/iv-19.tar.gz"
tar xzf nrn-7.5.tar.gz && tar xzf iv-19.tar.gz
mkdir iv && mkdir nrn
# Preinstall configure
cd iv-19 && ./configure --prefix='/home/simulators/neuron7.5/iv'
make && make install clean
cd .. && cd nrn-7.5
./configure --prefix='/home/simulators/neuron7.5/nrn' --with-nrnpython --with-paranrn --with-iv
make && make install clean
# Install
cd src/nrnpython && python setup.py install --home=/home/simulators/neuron7.5
########################################################################

cd /home/simulators

################################ NEST ##################################
# Install NEST setup
mkdir nest2.16
wget "https://github.com/nest/nest-simulator/archive/v2.16.0.tar.gz"
tar xzf nest-2.16.0.tar.gz && cd nest-2.16.0
# Preinstall configure
cmake -DCMAKE_INSTALL_PREFIX:PATH=/simulators/nest2.16/
# Install
make && make install clean
########################################################################

############################# POST-INSTALL #############################
# create installed_sims.pth
# vi /envs/py27-cerebunit/lib/python2.7/site-packages/installed_sims.pth
# Add NEURON to path
#/simulators/neuron7.5/lib/python
# Add IV and NEURON to path variable
#export PATH="/simulators/neuron7.5/iv/x86_64/bin:$PATH"
#export PATH="/simulators/neuron7.5/nrn/x86_64/bin:$PATH"
# Add NEST to path
#/simulators/nest2.16/lib/python2.7/site-packages
