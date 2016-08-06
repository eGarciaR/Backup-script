#BACKUP SCRIPT

This is a backup script for linux systems. Currently is working for 
Archlinux using KDE as a desktop environment.

TIPS:

To make a correct backup you should create a backup folder in your system, 
let's say, for example, in /backup: 

> mkdir /backup

Once we have created the backup folder, is a good idea to give it only root 
permissions:

> sudo chmod 700 /backup

As we have our backup folder created, it's time to create a new  partition 
in an external device. This can be done using fdisk.
Since now, I'll assume that my external device is /dev/sdd3.
So, let's mount our partition to the backup folder:

> sudo mount /dev/sdd3 /backup

[OPTIONAL]
This is good for doing the backup when we want, but I want the 
computer to do the backup weekly. So first of all, we must change our /etc/fstab 
configuration file. With this setup we'll be able to mount the device into 
our backup folder everytime the system starts:

Add this line to /etc/fstab
/dev/sdd3	/backup	      ext4       ro,noatime       0      2

ro option is used to mount the device in read only mode. This is crucial to 
avoid unwanted modifications in our backup folder. If for some reason we 
want to modify the folder we can use that command:

> sudo mount -o remount,rw /dev/sdd3 /backup

Now we can launch the script. Enjoy :)   
