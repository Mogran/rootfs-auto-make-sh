#!/bin/sh

echo "romve rootfs files ... "
rm -rf dev etc home root var proc sys mnt tmp lib
rm -rf usr/lib
echo "done"
