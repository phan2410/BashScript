#!/bin/bash

# Reminder
printf "PREREQUISITE============================================================\n"
printf "\n"
printf "Make Sure This Script Is Executed Under SUDO Privilege!\n"
select yn in "Yes" "Not Sure"; do
    case $yn in
        Yes ) break;;
        "Not Sure" )  	printf "For Ex. $ sudo bash ...\n";
			printf "For Ex. # bash ...\n";
			exit;;
    esac
done
printf "\n"

# Check boot
printf "BOOT====================================================================\n"
printf "\n"
printf "Can Ubuntu And Other OS Can Be Booted Up Normally?\n"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) 	printf "1.Use An USB To Boot Up Into Linux With Internet Connection\n";
		printf "2.Install Boot Repair, Execute And Follow Instructions\n";
		printf "3.Change BIOS Boot Order\n";
		printf "4.Customize Grub\n";
		exit;;
    esac
done
printf "\n"

# FIX THE GRUB-BOOT MENU:
# Must have one and only one ESP/EFI partition before running boot-repair
# Make sure the following things are configured in /etc/default/grub
GRUB_DEFAULT="Ubuntu"       # default =0, but I specify it out to make it clearer
GRUB_TIMEOUT_STYLE=hidden   # default =menu, but I want to hide it
GRUB_TIMEOUT=0              # don't want to wait
GRUB_RECORDFAIL_TIMEOUT=0   # must have var, don't know why
# Make sure set these vars in /etc/grub.d/30_os-prober
quick_boot="0" # this prevents grub-timeout overridding
# doing this will help bypass the grub menu at boot time 
# cause bluetooth keyboard doesnot work at this point anyway,
# so to boot into windows 10, once we login ubuntu, we can use this command
sudo grub-reboot "Windows 10 (on /dev/sda1)"   # this will only affect the next boot once
# or sudo grub-reboot 2 (option number in 30_os-prober), and then restart, you will see it automatically boots to windows
# remember: don't set GRUB_DISABLE_OS_PROBER=true, otherwise, we can never boot to any OS except ubuntu


# Update manually
printf "UPDATE MANUALLY=========================================================\n"
printf "\n"
printf "Please Manually Check For Any Last Minute Updates:\n"
printf "  1.Launch the 'Software Updater' tool from the Unity Dash\n"
printf "  2.Click the button to check for updates\n"
printf "  3.Install (if needed)\n"
printf "Are you finished?\n"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done
printf "\n"
printf "Next, Manually Configure 'Software & Updates'\n"
printf "  1.Open up the 'Software & Updates' tool from the Unity Dash\n"
printf "  2.Check all boxes and choose 'Main server' for download source under the 'Ubuntu Software' tab\n"
printf "  3.Click the 'Additional Drivers' tab\n"
printf "  4.Follow any on-screen prompts to check for, install and apply any changes\n"
printf "  5.Check Canonical Partners up under the 'Other Software' tab\n"
printf "Are you finished?\n"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done
printf "\n"
printf "SETTING UP==============================================================\n"
printf "\n"

# CHANGE APPEARANCE: Settings > Appearance > Theme

# DRIVE MOUNT AT STARTUP: automatically mount a drive
sudo cp /etc/fstab /etc/fstab.backup
# See more at https://askubuntu.com/questions/164926/how-to-make-partitions-mount-at-startup
sudo blkid ...

# INSTALL VIRTUALBOX
# MOUNT PHYSICAL WINDOWS 10:
# First must add user to disk group
sudo usermod -aG disk $USER
# and logout/login (best is to restart the computer)
# Then make some disk images
sudo VBoxManage createmedium disk --filename "/home/fan/.virtualbox/real_win10.vmdk" --variant=RawDisk --format=VMDK --property RawDrive=/dev/sda
sudo VBoxManage createmedium disk --filename "/home/fan/.virtualbox/real_d.vmdk" --variant=RawDisk --format=VMDK --property RawDrive=/dev/sdb
# Then create windows 10 VM and attach these storages


printf "Please manually install: google-chrome, ibus-unikey, dropbox, pycharm, redshift, ksnip, cloudflare-wrap, anki"

#INSTALL GNOME EXTENSION MANAGER
sudo apt-get install gnome-shell-extension-manager
# LIST OF BEST EXTENSIONS
Auto Move Windows # to configure the workspace where an app will be opened
Clipboard Indicator # to save/retrieve old clipboard values
Dash to Panel # to make a windows-like taskbar
gTile # to help arrange multiple windows on one screen
Improved Workspace Indicator # to show the current workspace number in taskbar
Notes # sticky notes
OpenWeather # to see weather
Sensory Perception # to watch for temperature of cpus/disks
Wallpaper Switcher # To switch desktop background. Please point to /d/DesktopWallpaper

# CONFIG StartUp App
sudo apt install gnome-startup-applications # to install it
# Config CloudFlare Warp Stray icon: 
# 1. disable the original task bar icon from Cloudflare
# 2. cd /opt && sudo git clone https://github.com/mrmoein/warp-cloudflare-gui
# 3. cd warp-cloudflare-gui && pip3 install -r requirements.txt
# 3. open StartUp software, and add an item, give name and give command: 
#    bash --login -c 'export PATH="$PATH:$HOME/.local/bin";python3 /opt/warp-cloudflare-gui/main.py --hide;disown -r;exit 0'
# then save


# ENABLE HIBERNATION: https://ubuntuhandbook.org/index.php/2021/08/enable-hibernate-ubuntu-21-10/
# SecureBoot has to be turned off in bios setting
# 1. find UUID using cat /etc/fstab |grep swap
# 2. sudo gedit /etc/default/grub, edit: GRUB_CMDLINE_LINUX_DEFAULT="quiet splash resume=UUID=xxx"
# 3. sudo update-grub
# 4. test it: xdg-screensaver lock && sudo systemctl hibernate
# 5. if ok, then make hibernate option appear at GUI to use
# 5.1 make Hibernate option appear at gnome power menu via extention: Hibernate Status Button, 
#     but Hybrid Sleep option also appears and doesnot work as expected, and cannot be get rid of for now.
# 5.2 make Hibernate option appear by installing fan tray icon

# PREPARE UTILS SCRIPT
# Creates fanCleanUp -> check the script in the repo
# Creates rebootToWin -> check the script in the repo

#IN CASE NEED to config SAMBA
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.backup
echo "[share]" | sudo tee -a /etc/samba/smb.conf
echo "comment = Ubuntu File Server Share" | sudo tee -a /etc/samba/smb.conf
echo "path = /srv/samba/share" | sudo tee -a /etc/samba/smb.conf
echo "browsable = yes" | sudo tee -a /etc/samba/smb.conf
echo "guest ok = yes" | sudo tee -a /etc/samba/smb.conf
echo "read only = no" | sudo tee -a /etc/samba/smb.conf
echo "create mask = 0755" | sudo tee -a /etc/samba/smb.conf
sudo mkdir -p /srv/samba/share
sudo chown nobody:nogroup /srv/samba/share/
sudo systemctl restart smbd.service
sudo systemctl restart nmbd.service

printf "\n"
printf "Do you want to install longman dictionary ldoce5?\n"
select yn in "Yes" "No"; do
    case $yn in
        Yes )   printf "Please copy directory ldoce5.data to an arbitrary location on your disk!\n"
		printf "Are you finished?\n"
		select yn in "Yes" "No"; do
    			case $yn in
		        	Yes )	sudo apt-get update
					sudo apt-get install pyqt4-dev-tools python-lxml python-pip &&
					pip install whoosh==2.5.7 &&
					sudo apt-get install python-gst0.10 gstreamer0.10-plugins-good python-qt4-phonon &&
					cd ~/Downloads &&
					git clone https://github.com/ciscorn/ldoce5viewer &&
					cd ldoce5viewer &&
					make build &&
					sudo make install &&
					cd .. &&
					rm -r -f ldoce5viewer
					break;;
			        No ) break;;
			esac
		done
		break;;
        No ) break;;
    esac
done
printf "\n"

printf "Do you want to create an executable file to launch Matlab_2017a_Linux_x86-64?\n"
select yn in "Yes" "No"; do
    case $yn in
        Yes )   echo "#!/bin/bash" > ~/matlab
		echo "/usr/local/MATLAB/R2017a/bin/matlab" >> ~/matlab
		chmod +x ~/matlab
		break;;
        No ) exit;;
    esac
done
printf "\n"

sudo bash ~/fanCleanUp.bash

printf "\n"
printf "Further Recommendation:\n"
printf "  1.Power options when pressing power button or closing the lid\n"

printf "\n"
printf "DONE====================================================================\n"



