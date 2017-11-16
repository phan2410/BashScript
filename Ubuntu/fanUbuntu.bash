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

# CHANGE NEED: SHOULD SEPARATE THOSE SETTINGS FOR CURRENT USER, NOT RUN WITH SUDO PRIVILEGE
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true
gsettings set com.canonical.Unity.Launcher launcher-position Bottom

# Going to automatically mount a drive
sudo cp /etc/fstab /etc/fstab.backup
# See more at https://askubuntu.com/questions/164926/how-to-make-partitions-mount-at-startup
sudo blkid ...

# Creates fanCleanUp
echo "#!/bin/bash" > ~/fanCleanUp.bash
echo "echo \"Cleaning Up\" &&" >> ~/fanCleanUp.bash
echo "sudo apt-get -f install &&" >> ~/fanCleanUp.bash
echo "sudo apt-get autoremove &&" >> ~/fanCleanUp.bash
echo "sudo apt-get -y autoclean &&" >> ~/fanCleanUp.bash
echo "sudo apt-get -y clean" >> ~/fanCleanUp.bash
chmod +x ~/fanCleanUp.bash

sudo apt-get update &&        # Fetches the list of available updates
sudo apt-get remove yelp thunderbird rhythmbox eog && 	# Remove unnecessary packages
sudo apt-get upgrade &&       # Strictly upgrades the current packages
sudo apt-get dist-upgrade     # Installs updates (new ones)

sudo apt-get install ubuntu-restricted-extras flashplugin-installer git openssh-server openssh-client libgnome-keyring-dev &&
sudo make --directory=/usr/share/doc/git/contrib/credential/gnome-keyring &&
git config --global credential.helper /usr/share/doc/git/contrib/credential/gnome-keyring/git-credential-gnome-keyring

sudo apt-get update
sudo apt-get install default-jre vlc browser-plugin-vlc gimp gimp-data gimp-plugin-registry gimp-data-extras bleachbit tlp tlp-rdw redshift redshift-gtk &&
sudo tlp start
redshift-gtk &

sudo add-apt-repository ppa:noobslab/apps &&
sudo apt-get update &&
sudo apt-get install xdman-downloader

mkdir -p ~/Downloads
cd ~/Downloads

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &&
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list &&
sudo apt-get update &&
sudo apt-get install google-chrome-stable


sudo apt-get update &&
sudo apt-get install ibus-unikey samba emacs &&
echo "alias emacs=\"emacs -nw\"" >> ~/.bashrc
cd ~/Downloads && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/Downloads/.dropbox-dist/dropboxd &
# Here somehow I must automatically mount driver to not double space of sync folder version in windows
sudo apt-get install nautilus-dropbox &&
printf "now we are going to optional sync folder ...."


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
ibus restart

printf "ibus-unikey: Require Manual Configuration ...\n"
printf "  1.Open Text Entry from the Unity Dash\n"
printf "  2.Click the button + to add an input source\n"
printf "  3.Add Vietnamese(Unikey) with key 'viet' in search box\n"
printf "  4.Set up an hot key for switching source\n"
printf "Are you finished?\n"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) exit;;
    esac
done

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



