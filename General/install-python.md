# LINUX

## Via Repo

## Via source
### Debian-based

```shell
sudo apt-get update
sudo apt-get install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev

cd ~/Downloads
wget https://www.python.org/ftp/python/3.10.1/Python-3.10.1.tgz
tar -xf Python-3.10.1.tgz
cd Python-3.10.1
./configure --enable-optimizations
sudo make altinstall
```
