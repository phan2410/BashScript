# LINUX

## Via Repo

## Via source
### Debian-based

```shell
sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev tk-dev liblzma-dev lzma

# only try the following if the command above doesnot work
# sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
# libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
# libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev \
# libgdbm-dev libnss3-dev libedit-dev libc6-dev

cd ~/Downloads
wget https://www.python.org/ftp/python/3.10.1/Python-3.10.1.tgz
tar -xf Python-3.10.1.tgz
cd Python-3.10.1
./configure --enable-optimizations
sudo make altinstall

# If failed, try removing Python-3.10.1, and execute the following ones
# cd .. && rm -rf Python-3.10.1
# tar -xf Python-3.10.1.tgz
# cd Python-3.10.1
# ./configure --enable-optimizations  -with-lto  --with-pydebug
# make -j 6  # adjust for number of your CPU cores
# sudo make altinstall

```
