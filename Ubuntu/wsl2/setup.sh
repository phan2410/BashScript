# We can control memory and cpus assigned to wsl2
# FILE c:/users/name/.wslconfig (find microsoft template)
# Settings apply across all Linux distros running on WSL 2
[wsl2]
memory=8GB 
processors=4
# END

# To Enable systemd inside wsl2
cat /etc/wsl.conf
# FILE /etc/wsl.conf
[boot]
systemd=true
# END

# Install dropbox
# Read https://www.dropbox.com/install-linux
sudo apt-get install libc6
sudo apt-get install libglapi-mesa
sudo apt-get install libxdamage1
sudo apt-get install libxfixes3
sudo apt-get install libxcb-glx0
sudo apt-get install libxcb-dri2-0
sudo apt-get install libxcb-dri3-0
sudo apt-get install libxcb-present0
sudo apt-get install libxcb-sync1
sudo apt-get install libxshmfence1
sudo apt-get install libxxf86vm1
sudo apt install firefox
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# Next, run the Dropbox daemon from the newly created .dropbox-dist folder.
~/.dropbox-dist/dropboxd

# If you’re running Dropbox on your server for the first time, 
# you’ll be asked to copy and paste a link in a working browser to create a new account or add your server to an existing account. 
# Once you do, your Dropbox folder will be created in your home directory. 
# Download this Python script to control Dropbox from the command line. For easy access, put a symlink to the script anywhere in your PATH.
# Link: https://www.dropbox.com/download?dl=packages/dropbox.py

# Do not execute these lines below, but just make sure that
# sudo chown "$USER" "$HOME"
# sudo chown -R "$USER" ~/Dropbox ~/.dropbox
# sudo chattr -R -i ~/Dropbox
# sudo chmod -R u+rw ~/Dropbox ~/.dropbox

