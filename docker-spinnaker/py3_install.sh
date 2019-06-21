#!/bin/sh
# script for setting up docker based on ubuntu:19.04
# run this script after:
# base_install.sh
# to run this script
# chmod +x py3_install.sh
# bash py3_install.sh

# Create environment for python3
virtualenv -p /usr/bin/python3 /envs/py3-spinnaker
source /envs/py3-spinnaker/bin/activate

# Setup environment
pip3 install -U numpy scipy matplotlib pandas mpi4py ipython jupyter quantities neo elephant bokeh pyneuroml
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
#cd / && cd simulators && mkdir py3_moose3.1 && cd py3_moose3.1
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

cd / && cd simulators

############################# sPyNNaker8 ###############################
source /envs/py3-spinnaker/bin/activate
## Install pre-built package (only for python 2)
#pip install sPyNNaker8
mkdir spinnaker_pynn && cd spinnaker_pynn
git clone https://github.com/SpiNNakerManchester/SpiNNUtils.git
git clone https://github.com/SpiNNakerManchester/SpiNNStorageHandlers.git
git clone https://github.com/SpiNNakerManchester/SpiNNMachine.git
git clone https://github.com/SpiNNakerManchester/PACMAN.git
git clone https://github.com/SpiNNakerManchester/DataSpecification.git
git clone https://github.com/SpiNNakerManchester/spalloc.git
git clone https://github.com/SpiNNakerManchester/SpiNNFrontEndCommon.git
git clone https://github.com/SpiNNakerManchester/sPyNNaker.git
# all the above are needed to be installed pior to sPyNNaker8
git clone https://github.com/SpiNNakerManchester/sPyNNaker8.git
# SpiNNMan is required for installing pyNN-spiNNaker
git clone https://github.com/SpiNNakerManchester/SpiNNMan.git
pip3 install ./SpiNNUtils ./SpiNNStorageHandlers ./SpiNNMachine ./PACMAN ./DataSpecification ./spalloc ./SpiNNFrontEndCommon ./sPyNNaker ./sPyNNaker8 ./SpiNNMan
## Install pyNN-spiNNaker NOTE: setup_pynn NOT setup-pynn (which is for pip installable/ version)
python3 -m spynnaker8.setup_pynn
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
pip3 install ./hbp-neuromorphic-client
deactivate
########################################################################


################### Setup C-environment variables ######################
cd /repos/
# NOTE the latest Version 8-2018-q4-major Linux 64-bit is not suitable
wget -O 6-2017-q2-update-linux.tar.bz2 "https://developer.arm.com/-/media/Files/downloads/gnu-rm/6-2017q2/gcc-arm-none-eabi-6-2017-q2-update-linux.tar.bz2?revision=2cc92fb5-3e0e-402d-9197-bdfc8224d8a5?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,6-2017-q2-update"
tar xjf 6-2017-q2-update-linux.tar.bz2
# set the path into ~/.bashrc or ~/.profile (shown here)
echo "" >> ~/.bashrc
echo -E "export PATH=\"\$PATH:$(pwd)/gcc-arm-none-eabi-6-2017-q2-update/bin\"" >> ~/.bashrc
#source ~/.bashrc
#
cd /simulators/spinnaker_pynn
#
git clone https://github.com/SpiNNakerManchester/spinnaker_tools.git
git clone https://github.com/SpiNNakerManchester/spinn_common.git
echo "" >> ~/.profile
echo "# Add ~/spinnaker_tools to SPINN_DIRS environment variable" >> ~/.profile
echo -E "export SPINN_DIRS=\"$(pwd)/spinnaker_tools\"" >> ~/.profile
echo "# Add ~/spinnaker_tools/tools to PATH environment variable" >> ~/.profile
echo -E "export PATH=\"$(pwd)/spinnaker_tools/tools\"" >> ~/.profile
echo "# Add ~/spinnaker_tools/tools to PERL5LIB environment variable" >> ~/.profile
echo -E "export PERL5LIB=\"$(pwd)/spinnaker_tools/tools\"" >> ~/.profile
echo "# Add ~/sPyNNaker/neural_modelling to NEURAL_MODELLING_DIRS environment variable" >> ~/.profile
echo -E "export NEURAL_MODELLING_DIRS=\"$(pwd)/sPyNNaker/neural_modelling\"" >> ~/.profile
#source ~/.bashrc 
########################################################################



############################ Build C-code ##############################
#cd /simulators/spinnaker_pynn
#
#cd spinnaker_tools
#source $PWD/setup
#make clean
#make # || exit $?
#cd ..
#cd spinn_common
#make clean
#make install-clean
#make # || exit $?
#make install
#cd ..
#cd SpiNNFrontEndCommon/c_common/
#cd front_end_common_lib/
#make install-clean
#cd ..
#make clean
#make # || exit $?
#make install
#cd ../..
#cd sPyNNaker/neural_modelling/
#source $PWD/setup.bash
#make clean
#make # || exit $?
#cd ../../SpiNNakerGraphFrontEnd/spinnaker_graph_front_end/examples/
#make clean
#make || exit $?
#echo "completed"
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
