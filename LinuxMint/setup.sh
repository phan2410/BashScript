# Most of things are like in Ubuntu

# TRY USE DEFAULT before installing anything

# [Unikey]
# Go to LM Menu (press Super) > Search for Input method 
#  > Choose Vietnamese > process as instruction there

# [Docker]
# https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository
# MUST CHECK based on Ubuntu version, here I use jammy, so use this command instead
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# REMEMBER to do POST INSTALLATION Guide

# Install Docker desktop GUI
# https://docs.docker.com/desktop/release-notes/
# enable: systemctl --user enable docker-desktop
# and configure the disk image to /home/fan/.docker
# don't Install docker-compose from apt, just use bash script or check integration in docker-desktop
