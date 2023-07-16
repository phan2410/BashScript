# LINUX

## Via Repo

## Via source
### Debian-based

```shell
sudo apt update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev \
libgdbm-dev libnss3-dev libedit-dev libc6-dev

cd ~/Downloads
wget https://www.python.org/ftp/python/3.10.1/Python-3.10.1.tgz
tar -xf Python-3.10.1.tgz
cd Python-3.10.1
./configure --enable-optimizations
sudo make altinstall
```
