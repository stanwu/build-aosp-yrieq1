#!/bin/bash

#Disable interactive
export DEBIAN_FRONTEND=noninteractive

#Init build environment
sudo apt-get update && sudo apt-get -y install libncurses-dev libelf-dev fakeroot dwarves openjdk-8-jdk android-tools-adb bc bison build-essential curl flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-gtk3-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc yasm zip zlib1g-dev git-core python3.8 libncurses5
echo "Build environment installed"

#Init python
sudo update-alternatives --install /bin/python python /usr/bin/python3 1
sudo update-alternatives --install /bin/python python /usr/bin/python3.8 2
sudo update-alternatives --config python

if [ -z "$(git config user.email)" ]; then
   git config --global user.email "aosp-dev@github.com"
   git config --global user.name "github-user"
fi

#Install repo command
mkdir -p $(pwd)/bin
export PATH=$(pwd)/bin:$PATH
curl -s https://storage.googleapis.com/git-repo-downloads/repo > $(pwd)/bin/repo
chmod a+x $(pwd)/bin/repo

bin/repo init -u https://android.googlesource.com/platform/manifest -b android-11.0.0_r1
bin/repo sync -cdj16 --no-tags
