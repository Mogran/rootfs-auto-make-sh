#!/bin/sh

mkdir dev etc lib home root usr var proc sys mnt tmp
mkdir usr/bin usr/sbin usr/lib

touch etc/inittab
echo "::sysinit:/etc/init.d/rcS" > etc/inittab
echo "::askfirst:-/bin/sh" >> etc/inittab
echo "::restart:/sbin/init" >> etc/inittab
echo "::ctrlaltdel:/sbin/reboot" >> etc/inittab
echo '::shutdown:/bin/umount -a -r' >> etc/inittab

mkdir etc/init.d
touch etc/init.d/rcS
chmod a+x etc/init.d/rcS
echo "#!/bin/sh" > etc/init.d/rcS
echo "mount -a" >> etc/init.d/rcS
echo "mkdir /dev/pts" >> etc/init.d/rcS
echo "mount -t devpts devpts /dev/pts" >> etc/init.d/rcS
echo "echo /sbin/mdev > /proc/sys/kernel/hotplug" >> etc/init.d/rcS
echo "mdev -s" >> etc/init.d/rcS

touch etc/fstab
echo -e "#device\tmount-point\ttype\toptions\tdump\tfsck order" > etc/fstab
echo -e "proc\t/proc\tproc\tdefaults\t0\t0" >> etc/fstab
echo -e "sysfs\t/sys\tsysfs\tdefaults\t0\t0" >> etc/fstab
echo -e "tmpfs\t/dev\ttmpfs\tsize=64k,mode=0755\t0\t0" >> etc/fstab
echo -e "tmpfs\t/tmp\ttmpfs\tdefaults\t0\t0" >> etc/fstab

#ÐÞ¸ÄÌáÊ¾·û
touch etc/hostname
echo "TQ2416" > etc/hostname 

touch etc/profile
echo "HOSTNAME='/bin/hostname'"> etc/profile
echo "PS1='[\\u@\\h \\W]\\$ '" >> etc/profile
echo "PATH=/bin:/sbin:/usr/bin:/usr/sbin" >> etc/profile
echo "export PS1 HOSTNAME PATH" >> etc/profile 

touch etc/passwd
echo "root:x:0:0:root:/root:/bin/sh" > etc/passwd
echo '/bin/hostname -F /etc/hostname' >> etc/init.d/rcS 

mknod dev/null c 1 3
mknod dev/console c 5 1

#LDD_TARGET=bin/busybox
#CROSS_COMPILE=arm-unknown-linux-gnueabi-
#if [ "$CROSS_COMPILE" = "arm-unknown-linux-gnueabi-" ]
#then
#    for var in $(${CROSS_COMPILE}ldd --root . $LDD_TARGET | awk '{ print $1 }')
#    do
#        cp $(${CROSS_COMPILE}gcc -print-file-name=$var) lib/ -d
#        cp $(${CROSS_COMPILE}gcc -print-file-name=$var) lib/$(ls -l lib/$var | awk '{ print $NF }') -L
#    done
#else
#    for var in $(${CROSS_COMPILE}readelf -d $LDD_TARGET | grep 'Shared' | awk '{ print $NF }' | sed 's/[][]//g')
#    do
#        cp $(${CROSS_COMPILE}gcc -print-file-name=$var) lib/ -d
#        cp $(${CROSS_COMPILE}gcc -print-file-name=$var) lib/$(ls -l lib/$var | awk '{ print $NF }') -L
#    done
#fi
#EXTRA_LIB=ld-linux.so.3
#for var in $EXTRA_LIB
#do
#    cp $(${CROSS_COMPILE}gcc -print-file-name=$var) lib/ -d
#    cp $(${CROSS_COMPILE}gcc -print-file-name=$var) lib/$(ls -l lib/$var | awk '{ print $NF }') -L
#done
