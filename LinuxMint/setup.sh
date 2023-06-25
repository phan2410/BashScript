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
