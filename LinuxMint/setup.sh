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

# We can change the default root directory by updating the daemon configuration file
$ mkdir -p /tmp/new-docker-root
$ sudo nano /etc/docker/daemon.json
# Paste following
{ 
   "data-root": "/tmp/new-docker-root"
}
# END
$ sudo systemctl restart docker
$ sudo rm -rf /var/lib/docker
# docker info -f '{{ .DockerRootDir}}' should show: /tmp/new-docker-root

[docker-compose]
# don't Install docker-compose from apt, just use script to install
# Read https://docs.docker.com/compose/install/standalone/
curl -SL https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose


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


