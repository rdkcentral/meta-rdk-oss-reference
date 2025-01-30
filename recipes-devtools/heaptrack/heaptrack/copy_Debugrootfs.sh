#!/bin/bash

####################################################################################
# If not stated otherwise in this file or this component's LICENSE file the
# following copyright and licenses apply:
#
# Copyright 2024 Comcast Cable Communications Management, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
####################################################################################

:' #commenting as of now
for device in /dev/sd*; do
    if ! grep -qs $device /proc/mounts ; then
        echo "Mount the Device"
        mount $device /mnt/usb
    else
        echo "Already Mounted the Device"
    fi
done
'
if [ -b /dev/sda2 ]; then
    echo "Mouting the device"
    mount /dev/sda2 /mnt/usb
fi
cd /tmp/data
if [ ! -d /tmp/data/dbg_rootfs ]; then
    mkdir dbg_rootfs
else
    rm -rf dbg_rootfs
    mkdir dbg_rootfs
fi

cd  dbg_rootfs
rm -rf *

echo "Copying dbg rootfs to /tmp/data/dbg_rootfs"
cp /mnt/usb/*.gz /tmp/data/dbg_rootfs

echo "Done Copying the rootfs.Extracting!!"
tar -xvf *.gz

echo "Extraction Done."

target_directory1="/usr/lib"
target_directory2="/lib"

search_copy_symlinks() {
echo "dir:$1"
if [ -d "$1" ]; then
    echo "Finding symbolic links in '$1':"

    for entry in "$1"/*; do
        if [ -L $entry ]; then
            echo "Symbolic link: $entry"
if [ "$1" == "/usr/lib" ]; then
cp -P $entry /tmp/data/dbg_rootfs/usr/lib/.debug
else
cp -P $entry /tmp/data/dbg_rootfs/lib/.debug
fi
        fi
    done

    echo "Symlink search in '$1' completed."
else
    echo "Error: Directory '$1' not found."
fi

}

search_copy_symlinks "$target_directory1"

search_copy_symlinks "$target_directory2"
