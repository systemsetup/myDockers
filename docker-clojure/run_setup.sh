#!/bin/sh
# script for setting up docker based on ubuntu:20.04
# run this script after:
# sudo docker pull ubuntu:20.04
# sudo docker run -ti ubuntu:20.04 bash
# To get Ubuntu version do > cat /etc/issue
# apt-get -qq update
# apt-get install -y git
# git clone https://github.com/systemsetup/myDockers.git && cd myDockers/docker-clojure
# chmod +x run_setup.sh
# bash run_setup.sh

apt-get install -y wget bzip2 vim tmux tree lsof build-essential checkinstall openjdk-8-jdk leiningen

cd .. && cd .. 

git clone https://github.com/systemsetup/configVim.git  && cd configVim

cp vimrc ~/.vimrc
cp clojure.vim /usr/share/vim/vimfiles/ftplugin/clojure.vim
