#!/bin/sh
# script for setting up docker based on ubuntu:19.04
# run this script after:
# base_install.sh
# to run this script
# chmod +x py3_install.sh
# bash py3_install.sh

# Create environment for python3
virtualenv -p /usr/bin/python3 /envs/py3-spinnaker
source /envs/py3-spinnkaer/bin/activate

# Setup environment
pip3 install -U numpy scipy matplotlib pandas mpi4py ipython jupyter quantities neo elephant pynwb sciunit bokeh pyneuroml
pip3 install dask distributed --upgrade

# Deactivate the activated virtualenv once python related packages are installed
deactivate

# ** => places were configuration is made for Python3

# Got to root directory and create an installation directory where the installed simulator will be located
cd / && mkdir simulators && cd simulators

############################### NEURON ##################################
# Make installation directory go there and make two directories for installing the extracted packages
mkdir py3_neuron7.5 && cd py3_neuron7.5 && mkdir iv && mkdir nrn
# Download installation package in the created installation root directory
wget "http://www.neuron.yale.edu/ftp/neuron/versions/v7.5/nrn-7.5.tar.gz"
wget "http://www.neuron.yale.edu/ftp/neuron/versions/v7.5/iv-19.tar.gz"
# Extract them
tar xzf nrn-7.5.tar.gz && tar xzf iv-19.tar.gz
# Preinstall configure
cd iv-19 && ./configure --prefix='/simulators/py3_neuron7.5/iv'
make && make install clean
# Do the same for the other extracted package
cd .. && cd nrn-7.5
# ********************************************************************************************************************* Python3 Config
./configure --prefix='/simulators/py3_neuron7.5/nrn' --with-pyexe=python3 --with-nrnpython --with-paranrn --with-iv --disable-rx3d
make && make install clean
# Finally Install
cd src/nrnpython && python3 setup.py install --home=/simulators/py3_neuron7.5
#
# NOTE: For v7.5 ignore h3class.py error
# https://neurojustas.wordpress.com/2018/03/27/tutorial-installing-neuron-simulator-with-python-on-ubuntu-linux/
# https://www.neuron.yale.edu/phpBB/viewtopic.php?f=6&t=3834&p=16482&hilit=MetaHocObject#p16482
#
## Post-Installation Path configuration (**Required for running nrnivmodl command)
echo "" >> ~/.bashrc
echo "# Add IV and NEURON to path variable" >> ~/.bashrc
echo -E "export PATH=\"/simulators/py3_neuron7.5/iv/x86_64/bin:\$PATH\"" >> ~/.bashrc
echo -E "export PATH=\"/simulators/py3_neuron7.5/nrn/x86_64/bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc
########################################################################

cd / && cd simulators

################################ NEST ##################################
# Make installation directory and go there
mkdir py3_nest2.16 && cd py3_nest2.16
# Download installation package in the created installation root directory
wget "https://github.com/nest/nest-simulator/archive/v2.16.0.tar.gz"
# Extract them and go to the extracted folder
tar xzf v2.16.0.tar.gz && cd nest-simulator-2.16.0
# Preinstall configure
# *******************************************************************************************************:************** Python3 Config
#cmake -DCMAKE_INSTALL_PREFIX:PATH=/simulators/py3_nest2.16/ -DPYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3.6 --> outdated config for specifying python version
cmake -DCMAKE_INSTALL_PREFIX:PATH=/simulators/py3_nest2.16/ -Dwith-python=3
# Install
make && make install clean
########################################################################



################################ MOOSE #################################
## Install pre-built package
#source /envs/py3-spinnaker/bin/activate
#pip3 install pymoose
#deactivate
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
#source /envs/py3-spinnaker/bin/activate
## Install pre-built package
#pip3 install pyNN
# Alternatively
#mkdir py3_pyNN-0.9.4 && cd py3_pyNN-0.9.4
#git clone https://github.com/NeuralEnsemble/PyNN.git
#pip3 install --install-option="--prefix=/simulators/py3_pyNN-0.9.4" ./PyNN
#
# NOTE: it is recommended to run the command 'nrnivmodl' after PyNN install
#
#deactivate
########################################################################



############################# sPyNNaker8 ###############################
source /envs/py3-spinnaker/bin/activate
## Install pre-built package (only for python 2)
#pip install sPyNNaker8
cd /repos
git clone https://github.com/SpiNNakerManchester/SpiNNUtils.git
git clone https://github.com/SpiNNakerManchester/SpiNNStorageHandlers.git
git clone https://github.com/SpiNNakerManchester/SpiNNMachine.git
git clone https://github.com/SpiNNakerManchester/PACMAN.git
git clone https://github.com/SpiNNakerManchester/DataSpecification.git
git clone https://github.com/SpiNNakerManchester/spalloc.git
git clone https://github.com/SpiNNakerManchester/SpiNNFrontEndCommon.git
git clone https://github.com/SpiNNakerManchester/sPyNNaker.git
git clone https://github.com/SpiNNakerManchester/sPyNNaker8.git
pip3 install ./SpiNNUtils ./SpiNNStorageHandlers ./SpiNNMachine ./PACMAN ./DataSpecification ./spalloc ./SpiNNFrontEndCommon ./sPyNNaker ./sPyNNaker8
## Install pyNN-spiNNaker
python3 -m spynnaker8.setup-pynn
#deactivate
########################################################################



####################### hbp neuromorphic cli ###########################
cd /repos/
git clone -b cli https://github.com/HumanBrainProject/hbp-neuromorphic-client.git
#source /envs/py3-spinnaker/bin/activate
## Install
pip3 install ./hbp_neuromorphic_platform
deactivate
########################################################################



############################# POST-INSTALL #############################
# create installed_sims.pth
# vi /envs/py3-spinnaker/lib/python3.7/site-packages/installed_sims.pth
## Add NEURON to path
#/simulators/py3_neuron7.5/lib/python
## Add NEST to path
#/simulators/py3_nest2.16/lib/python3.7/site-packages
# Add PyNN to path
#/simulators/py3_pyNN-0.9.4/lib/python3.7/site-packages