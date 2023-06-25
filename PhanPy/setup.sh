sudo nano /etc/systemd/system/ngrok_ssh.service

# Paste following content
[Unit]
Description=Enable SSH via ngrok
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/home/fan/.local/bin/ngrok tcp 22
User=fan
Restart=always
Type=simple

[Install]
WantedBy=multi-user.target
# end
