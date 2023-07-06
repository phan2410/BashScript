# Most of things are like in Ubuntu

# TRY USE DEFAULT before installing anything

[UNIKEY]
# Go to LM Menu (press Super) > Search for Input method 
#  > Choose Vietnamese > process as instruction there

[DOCKER]
# https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository
# MUST CHECK based on Ubuntu version, here I use jammy, so use this command instead
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# REMEMBER to do POST INSTALLATION Guide

[Docker desktop GUI]
# https://docs.docker.com/desktop/release-notes/
# enable: systemctl --user enable docker-desktop
# and configure the disk image to /home/fan/.docker

[docker-compose]
# don't Install docker-compose from apt, just use bash script or check integration in docker-desktop


[WAKE ON LAN]
# https://necromuralist.github.io/posts/enabling-wake-on-lan/

sudo apt install ethtool
ip a # => try get mac address from enp#s0 interface

sudo ethtool enp7s0
which ethtool # => copy binary path 

sudo nano /etc/systemd/system/wol.service
# Paste following content
[Unit]
Description=Enable Wake On Lan

[Service]
Type=oneshot
ExecStart = </path/to/ethtool> --change <enpXs0> wol g

[Install]
WantedBy=basic.target
# end
# Enable the service
sudo systemctl daemon-reload
sudo systemctl enable wol.service
sudo systemctl start wol.service
systemctl status wol


