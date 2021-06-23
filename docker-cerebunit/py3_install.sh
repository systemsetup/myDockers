#!/bin/sh
# script for setting up docker based on ubuntu:16.04
# run this script after:
# base_install.sh
# to run this script
# chmod +x py3_install.sh
# bash py3_install.sh

# Create environment for python3
virtualenv -p /usr/bin/python3 /envs/py3-cerebmodels
source /envs/py3-cerebmodels/bin/activate

# Setup environment
pip3 install -U numpy scipy matplotlib pandas mpi4py ipython jupyter quantities efel neo elephant pynwb sciunit bokeh pyneuroml
pip3 install dask distributed --upgrade

# Deactivate the activated virtualenv once python related packages are installed
deactivate

# ** => places were configuration is made for Python3

# Got to root directory and create an installation directory where the installed simulator will be located
cd / && mkdir simulators && cd simulators

############################### NEURON ##################################
# Make installation directory go there and make two directories for installing the extracted packages
#mkdir neuron7.6 && cd neuron7.6 && mkdir iv && mkdir nrn
# Download installation package in the created installation root directory
#wget "http://www.neuron.yale.edu/ftp/neuron/versions/v7.7/nrn-7.5.tar.gz"
#wget "http://www.neuron.yale.edu/ftp/neuron/versions/v7.5/iv-19.tar.gz"
#wget "https://neuron.yale.edu/ftp/neuron/versions/v7.6/nrn-7.6.tar.gz"
#wget "https://neuron.yale.edu/ftp/neuron/versions/v7.6/iv-19.tar.gz"
# Extract them
#tar xzf nrn-7.6.tar.gz && tar xzf iv-19.tar.gz
# Preinstall configure
#cd iv-19 && ./configure --prefix='/simulators/neuron7.6/iv'
#make && make install clean
# Do the same for the other extracted package
#cd .. && cd nrn-7.6
# ********************************************************************************************************************* Python3 Config
#./configure --prefix='/simulators/neuron7.6/nrn' --with-pyexe=python3 --with-nrnpython --with-paranrn --with-iv --disable-rx3d
#make && make install clean
# Finally Install
#cd src/nrnpython && python3 setup.py install --home=/simulators/neuron7.6
#
# NOTE: For v7.5 ignore h3class.py error
# https://neurojustas.wordpress.com/2018/03/27/tutorial-installing-neuron-simulator-with-python-on-ubuntu-linux/
# https://www.neuron.yale.edu/phpBB/viewtopic.php?f=6&t=3834&p=16482&hilit=MetaHocObject#p16482
#
## Post-Installation Path configuration (**Required for running nrnivmodl command)
#echo "" >> ~/.bashrc
#echo "# Add IV and NEURON to path variable" >> ~/.bashrc
#echo -E "export PATH=\"/simulators/py3_neuron7.7/iv/x86_64/bin:\$PATH\"" >> ~/.bashrc
#echo -E "export PATH=\"/simulators/py3_neuron7.7/nrn/x86_64/bin:\$PATH\"" >> ~/.bashrc
#source ~/.bashrc
########################################################################
########################### ALTERNATIVELY ##############################
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
mkdir py3_pyNN && cd py3_pyNN
git clone https://github.com/NeuralEnsemble/PyNN.git
pip3 install --install-option="--prefix=/simulators/py3_pyNN" ./PyNN
#
# NOTE: it is recommended to run the command 'nrnivmodl' after PyNN install
#
deactivate
########################################################################



############################# POST-INSTALL #############################
# create installed_sims.pth
# vi /envs/py3-cerebmodels/lib/python3.x/site-packages/installed_sims.pth
## Add NEURON to path
#/simulators/py3_neuron7.7/lib/python
## Add NEST to path
#/simulators/nest2.20/lib/python3.x/site-packages
# Add PyNN to path
#/simulators/py3_pyNN/lib/python3.x/site-packages
