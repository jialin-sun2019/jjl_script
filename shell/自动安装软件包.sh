#########################################################################
# File Name: host_env_setup.sh
# Author: jialin_sun
# mail: jialin_sun2019@163.com 
# Created Time: 2022-02-26 10:39:16
#########################################################################
#!/bin/bash
set -x
script_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
# This script sets up a Ubuntu host to be able to create the image by
# installing all of the necessary files. It assumes a host with
# passwordless sudo
# Install a bunch of packages we need
read -d '' PACKAGES <<EOT
iproute2
gcc
g++
net-tools
libncurses5-dev
zlib1g:i386
libssl-dev
flex
bison
libselinux1
xterm
autoconf
libtool
texinfo
zlib1g-dev
gcc-multilib
build-essential
screen
pax
gawk
python3
python3-pexpect
python3-pip
python3-git
python3-jinja2
xz-utils
debianutils
iputils-ping
libegl1-mesa
libsdl1.2-dev
pylint3
cpio
EOT
set -e
sudo apt-get update
if [[ $(lsb_release -rs) == "16.04" ]]; then
	echo "Install packages on Ubuntu 16.04..."
	sudo apt purge -y libgnutls dev
elif [[ $(lsb_release -rs) == "18.04" ]]; then
	echo "Install packages on Ubuntu 18.04..."
else
	echo "Error: current OS not supported."
	exit 1
fi
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install -y $PACKAGES
echo "Now install Vivado, SDK, and Petalinux."
echo "Relogin to ensure the enviroment is properly set up."
