#!/bin/sh
# script for setting up docker based on ubuntu:16.04
# run this script after:
# base_install.sh
# to run this script
# chmod +x py27_install.sh
# bash py27_install.sh

# Create environment for python2.7
virtualenv -p /usr/bin/python2.7 /envs/py27-spinnaker
source /envs/py27-spinnaker/bin/activate

# Setup environment
pip install -U numpy scipy matplotlib pandas mpi4py ipython jupyter quantities neo elephant bokeh
pip install dask distributed --upgrade
pip install git+git://github.com/BlueBrain/eFEL

cd /
mkdir simulators && cd simulators

############################### NEURON ##################################
# Install NEURON setup
mkdir py27_neuron7.5 && cd py27_neuron7.5
wget "http://www.neuron.yale.edu/ftp/neuron/versions/v7.5/nrn-7.5.tar.gz"
wget "http://www.neuron.yale.edu/ftp/neuron/versions/v7.5/iv-19.tar.gz"
tar xzf nrn-7.5.tar.gz && tar xzf iv-19.tar.gz
mkdir iv && mkdir nrn
# Preinstall configure
cd iv-19 && ./configure --prefix='/simulators/py27_neuron7.5/iv'
make && make install clean
cd .. && cd nrn-7.5
./configure --prefix='/simulators/py27_neuron7.5/nrn' --with-nrnpython --with-paranrn --with-iv --disable-rx3d
make && make install clean
# Install
cd src/nrnpython && python setup.py install --home=/simulators/py27_neuron7.5
# NOTE: For v7.5 ignore h3class.py error
# https://neurojustas.wordpress.com/2018/03/27/tutorial-installing-neuron-simulator-with-python-on-ubuntu-linux/
# https://www.neuron.yale.edu/phpBB/viewtopic.php?f=6&t=3834&p=16482&hilit=MetaHocObject#p16482
#
echo "" >> ~/.bashrc
echo "# Add IV and NEURON to path variable" >> ~/.bashrc
echo -E "export PATH=\"/simulators/py27_neuron7.5/iv/x86_64/bin:\$PATH\"" >> ~/.bashrc
echo -E "export PATH=\"/simulators/py27_neuron7.5/nrn/x86_64/bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc
########################################################################

cd /
cd simulators

################################ NEST ##################################
# Install NEST setup
mkdir py27_nest2.16 && cd py27_nest2.16
wget "https://github.com/nest/nest-simulator/archive/v2.16.0.tar.gz"
tar xzf v2.16.0.tar.gz && cd nest-simulator-2.16.0
# Preinstall configure
cmake -DCMAKE_INSTALL_PREFIX:PATH=/simulators/py27_nest2.16/
# Install
make && make install clean
########################################################################


################################ MOOSE #################################
## Install pre-built package
#source /envs/py27-spinnaker/bin/activate
#pip install pymoose
#deactivate
## To Build and install from it
#cd / && cd simulators && mkdir py27_moose3.1 && cd py27_moose3.1
#git clone https://github.com/BhallaLab/moose
#cd moose/moose-core
#mkdir _build && cd _build
#cmake -DCMAKE_INSTALL_PREFIX:PATH=/simulators/py27_moose3.1
#make && ctest --output-on-failure
#make install clean
########################################################################



################################ BRIAN2 #################################
## Install pre-built package
#source /envs/py27-spinnaker/bin/activate
#pip3 install brian2
#deactivate
# Alternatively
#pip3 install pyparsing sympy sphinxcontrib-issuetracker sphinx
#
#cd / && cd simulators && mkdir py27_brian2-2.0.1 && cd py27_brian2-2.0.1
#git clone https://github.com/brian-team/brian2
#cd brain2
#python3 setup.py install --home=/simulators/py27_brian2-2.0.1
########################################################################

cd / && cd simulators

################################ PyNN #################################
#source /envs/py27-spinnaker/bin/activate
## Install pre-built package
#pip3 install pyNN
# Alternatively
#mkdir py27_pyNN-0.9.4 && cd py27_pyNN-0.9.4
#git clone https://github.com/NeuralEnsemble/PyNN.git
#pip3 install --install-option="--prefix=/simulators/py27_pyNN-0.9.4" ./PyNN
#
# NOTE: it is recommended to run the command 'nrnivmodl' after PyNN install
#
#deactivate
########################################################################



############################# sPyNNaker8 ###############################
source /envs/py27-spinnaker/bin/activate
## Install pre-built package (only for python 2)
#pip install sPyNNaker8
pip install sPyNNaker8
## Install pyNN-spiNNaker NOTE: setup-pynn NOT setup_pynn (which is for github version)
python -m spynnaker8.setup-pynn
#deactivate
# Post-installation setup .spynnaker.cfg
#echo "" >> ~/.spynnaker.cfg
echo "[Machine]" >> ~/.spynnaker.cfg
echo "machineName = 192.168.240.39" >> ~/.spynnaker.cfg
echo "version = 3" >> ~/.spynnaker.cfg
echo "#virtual_board = False" >> ~/.spynnaker.cfg
#source ~/.spynnaker.cfg
########################################################################


####################### hbp neuromorphic cli ###########################
cd /repos/
git clone -b cli https://github.com/HumanBrainProject/hbp-neuromorphic-client.git
#source /envs/py3-spinnaker/bin/activate
## Install-pip3 install ./hbp-neuromorphic-client
pip install ./hbp-neuromorphic-client
deactivate
########################################################################



############################# POST-INSTALL #############################
# create installed_sims.pth
# vi /envs/py27-spinnaker/lib/python2.7/site-packages/installed_sims.pth
# Add NEURON to path
#/simulators/py27_neuron7.5/lib/python
# Add NEST to path
#/simulators/py27_nest2.16/lib/python2.7/site-packages
# Add PyNN to path
#/simulators/py27_pyNN-0.9.4/lib/python2.7/site-packages
