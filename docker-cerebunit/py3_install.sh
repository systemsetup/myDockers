#!/bin/sh
# script for setting up docker based on ubuntu:20.04
# run this script after:
# base_install.sh
# to run this script
# chmod +x py3_install.sh
# bash py3_install.sh

# Create environment for python3
virtualenv -p /usr/bin/python3 /envs/py3-cerebmodels
source /envs/py3-cerebmodels/bin/activate

# Setup environment
pip3 install -U numpy scipy matplotlib pandas mpi4py ipython jupyter quantities efel neo elephant pynwb sciunit bokeh pyneuroml nose nineml requests
pip3 install dask distributed --upgrade

# Deactivate the activated virtualenv once python related packages are installed
deactivate

# ** => places were configuration is made for Python3

# Got to root directory and create an installation directory where the installed simulator will be located
cd / && mkdir simulators && cd simulators

############################### NEURON ##################################
source /envs/py3-cerebmodels/bin/activate
pip3 install neuron==7.8.2
deactivate
########################################################################

cd / && cd simulators

################################ NEST ##################################
# Make installation directory and go there
mkdir nest2.20 && cd nest2.20
# Download installation package in the created installation root directory
wget "https://github.com/nest/nest-simulator/archive/v2.20.0.tar.gz"
# Extract them and go to the extracted folder
tar xzf v2.20.0.tar.gz && cd nest-simulator-2.20.0
# Preinstall configure
# ********************************************************************************************************************* Python3 Config
cmake -DCMAKE_INSTALL_PREFIX:PATH=/simulators/nest2.20/ -DPYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3.8
# Install
make && make install clean
########################################################################


################################ MOOSE #################################
## Install pre-built package
source /envs/py3-cerebmodels/bin/activate
pip3 install pymoose
deactivate
## To Build and install from it
#cd / && cd simulators && mkdir py_moose3.1 && cd py_moose3.1
#git clone https://github.com/BhallaLab/moose
#cd moose/moose-core
#mkdir _build && cd _build
#cmake -DCMAKE_INSTALL_PREFIX:PATH=/simulators/py3_moose3.1
#make && ctest --output-on-failure
#make install clean
########################################################################



################################ BRIAN2 #################################
## Install pre-built package
#source /envs/py3-cerebmodels/bin/activate
#pip3 install brian2
#deactivate
# Alternatively
#pip3 install pyparsing sympy sphinxcontrib-issuetracker sphinx
#
#cd / && cd simulators && mkdir py3_brian2-2.0.1 && cd py3_brian2-2.0.1
#git clone https://github.com/brian-team/brian2
#cd brain2
#python3 setup.py install --home=/simulators/py3_brian2-2.0.1
########################################################################

cd / && cd simulators

################################ PyNN #################################
source /envs/py3-cerebmodels/bin/activate
## Install pre-built package
#pip3 install pyNN
# Alternatively
mkdir pyNN && cd pyNN
git clone https://github.com/NeuralEnsemble/PyNN.git
pip3 install --install-option="--prefix=/simulators/pyNN" ./PyNN
#
# NOTE: it is recommended to run the command 'nrnivmodl' after PyNN install
#
deactivate
########################################################################



############################# POST-INSTALL #############################
# create installed_sims.pth
# vi /envs/py3-cerebmodels/lib/python3.x/site-packages/installed_sims.pth
## Add NEURON to path
#/simulators/neuron7.8/lib/python
## Add NEST to path
#/simulators/nest2.20/lib/python3.x/site-packages
# Add PyNN to path
#/simulators/pyNN/lib/python3.x/site-packages
