# Overview
This is shell routine can auto make basic rootfs file which are essential to run linuxOS, when you 
have finished migrate busybox, the next steps always will be create different
files that needed by rootfs. So. this demo script can help you to improve your
work more effective.

# How to use this script ?

of course,you should get this script firstly.

- How to download ?
	- if you get a git, you can run code as follow:
	> git clone git@github.com:Morgan/rootfs-auto-make-sh.git

- How to use this?
	- cd $(Your_Busybox_Dir)
	- cd _install/
	- cp - rootfs-auto-make-sh/*.sh ./
	- sh make_rootfs.sh

- How to clean generated files?
	- cd $(Your_Busybox_Dir)
	- cd _install/
	- sh clean_rootfs.sh


# The histoy version
- 2016.09.27 add rootfs_make.sh file, version 0.1
- 2016.09.27 fix some bugs and test on arm9 and busybox-1.23.2-stable version.
