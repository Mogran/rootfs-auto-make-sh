#!/bin/sh

mkdir dev etc lib home root var proc sys mnt tmp
mkdir usr/lib

touch etc/inittab
echo "::sysinit:/etc/init.d/rcS" > etc/inittab
echo "::askfirst:-/bin/sh" >> etc/inittab
echo "::restart:/sbin/init" >> etc/inittab
echo "::ctrlaltdel:/sbin/reboot" >> etc/inittab
echo '::shutdown:/bin/umount -a -r' >> etc/inittab

mkdir etc/init.d
mkdir etc/rc.d
mkdir etc/rc.d/init.d
touch etc/init.d/rcS
chmod a+x etc/init.d/rcS
echo "#!/bin/sh" > etc/init.d/rcS
echo "mount -a" >> etc/init.d/rcS
echo "mkdir /dev/pts" >> etc/init.d/rcS
echo "mount -t devpts devpts /dev/pts" >> etc/init.d/rcS
echo "echo /sbin/mdev > /proc/sys/kernel/hotplug" >> etc/init.d/rcS
echo "mdev -s" >> etc/init.d/rcS
echo "etc/rc.d/init.d/odf_start &" >> etc/init.d/rcS

touch etc/hosts
echo "#host files" > etc/hosts
echo "127.0.0.1  localhost" >>  etc/hosts

touch etc/uart0_config.cfg
echo "DEV=/dev/ttySAC0" > etc/uart0_config.cfg
echo "SPEED=115200" >> etc/uart0_config.cfg
echo "DATABITS=8" >> etc/uart0_config.cfg
echo "STOPBITS=1" >> etc/uart0_config.cfg
echo "PARITY=N" >> etc/uart0_config.cfg

touch etc/uart1_config.cfg
echo "DEV=/dev/ttySAC1" > etc/uart1_config.cfg
echo "SPEED=115200" >> etc/uart1_config.cfg
echo "DATABITS=8" >> etc/uart1_config.cfg
echo "STOPBITS=1" >> etc/uart1_config.cfg
echo "PARITY=N" >> etc/uart1_config.cfg

touch etc/fw_env.config
echo "#MTD device name\tDevice offset\t Env.szie\tFlash sector size\tNumber of sectors\t" > etc/fw_env.config 
echo "/dev/mtd1       \t0x00000      \t  0x20000\t   0x20000             \t1\t" >> etc/fw_env.config 

touch etc/fstab
echo "#device\tmount-point\ttype\toptions\tdump\tfsck order" > etc/fstab
echo "proc\t/proc\tproc\tdefaults\t0\t0" >> etc/fstab
echo "sysfs\t/sys\tsysfs\tdefaults\t0\t0" >> etc/fstab
echo "tmpfs\t/dev\ttmpfs\tsize=64k,mode=0755\t0\t0" >> etc/fstab
echo "tmpfs\t/tmp\ttmpfs\tdefaults\t0\t0" >> etc/fstab

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

sudo mknod dev/null c 1 3
sudo mknod dev/console c 5 1

CROSS_COMPILE=arm-linux-
if [ "$CROSS_COMPILE" = "arm-linux-" ]
then	
	cp -a /home/damien/prj-odf/cross-compile/arm-4.3.2/arm-none-linux-gnueabi/libc/lib/* lib/
	arm-linux-strip ./lib/*
fi

