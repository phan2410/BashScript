# Fix locale when ssh
# Add these lines to ~/.bashrc
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8


sudo nano /etc/systemd/system/ngrok_ssh.service

# Paste following content
[Unit]
Description=Enable SSH via ngrok
After=network-online.target
Wants=network-online.target

[Service]
ExecStartPre=/home/fan/.local/bin/ngrok update
ExecStart=/home/fan/.local/bin/ngrok tcp 22
User=fan
Restart=always
Type=simple

[Install]
WantedBy=multi-user.target
# end
