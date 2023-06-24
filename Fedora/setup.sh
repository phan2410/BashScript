#!/bin/bash


# INSTALL NVIDIA DRIVER
lspci | grep -Ei 'VGA|3D'
lsmod | grep nouveau
lsmod | grep nvidia

sudo dnf remove xorg-x11-drv-nouveau -y

sudo dnf update --refresh

sudo reboot

sudo dnf install kernel-headers kernel-devel dkms

sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda

nvidia-smi

# If still no, then go to https://www.nvidia.com/download/index.aspx?lang=en-us
# download driver for nvidia

# To use video acceleration on video players like VLC
sudo dnf install nvidia-vaapi-driver libva-utils vdpauinfo


# INSTALL VIRTUALBOX

sudo dnf -y install @development-tools
sudo dnf install kernel-headers kernel-devel dkms -y

sudo reboot

# For fedora 38
cat <<EOF | sudo tee /etc/yum.repos.d/virtualbox.repo 
[virtualbox]
name=Fedora VirtualBox Repo
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/38/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox_2016.asc
EOF


sudo dnf search virtualbox

sudo dnf install VirtualBox-7.0

sudo usermod -a -G vboxusers $USER
newgrp vboxusers
id $USER
