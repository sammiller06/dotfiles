# Change drive permissions
sudo chmod -R ugo+rwx /mnt #ugo means user, group, other. rw means read, write. can also add x for execute

# Setup Ananconda
## Download the installer - may need to change version name
wget https://repo.anaconda.com/archive/Anaconda3-5.3.1-Linux-x86_64.sh
## Run installation script
bash Anaconda3*.sh
source ~/.bashrc
## Create flights environment
conda create --name flights
source activate flights


# Clone git repo
cd /mnt
git clone https://github.com/sammiller06/Flights.git
cp Flights/src/Tech/connection.py /mnt/anaconda3/lib/python3.7/multiprocessing/connection.py #fix mulitprocessing bug for large files

# Setup AzCopy
## (on Ubuntu 18.04) Install libicu55 and libicurl3 dependency
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt-get update
sudo apt-get install libicu55
sudo apt-get install libcurl3
## Install azcopy
echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod/ xenial main" > azure.list
sudo cp ./azure.list /etc/apt/sources.list.d/
sudo apt-key adv --keyserver packages.microsoft.com --recv-keys EB3E94ADBE1229CF # if on WSL:curl -sL "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xEB3E94ADBE1229CF" | sudo apt-key add
sudo apt-get update
sudo apt-get install azcopy

# Mount drives
## Partition
(echo n; echo p; echo 1; echo ; echo ; echo w) | sudo fdisk /dev/<drive name e.g. sdc>
## Make filesystem in partition
sudo mkfs -t ext4 /dev/<filesystem name e.g. sdc1>
## Mount drive
sudo mkdir /<drivename e.g. datadrive> && sudo mount /dev/sdc1 /<drivename e.g. datadrive>
df -h # verify it worked
## Get UUID for fstab file
sudo -i blkid
## Insert this into fstab file (placeholder in "")
UUID="33333333-3b3b-3c3c-3d3d-3e3e3e3e3e3e"   /datadrive  ext4    defaults,nofail   1  2
## Change drive permissions
sudo chmod -R ugo+rwx /mnt #ugo means user, group, other. rw means read, write. can also add x for execute

# Install X2go server for GUI access
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:x2go/stable
sudo apt-get update
sudo apt-get install x2goserver x2goserver-xsession

#Setup vim
## For YCM setup 

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
touch ~/.vimrc
## Vimrc file
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
## For YCM installation
sudo apt-get install libcurl4
sudo apt install build-essential cmake python3-dev
cd ~/.vim/bundle/YouCompleteMe
python3 install.py