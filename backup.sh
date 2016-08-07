#!/bin/bash

usage="Usage: backup.sh"

log_message=""

#Looking in backup folder to have the latest modified file for the Incremental backup
latestModifiedFile=`ls -t /backup/ | head -n1`

if [ $# -ne 0 ] ; then

        echo $usage; exit 1

else
	#First we want to set the mount point to read-write option
	mount -o remount,rw /dev/sdd3 /backup

	#As we don't want to backup trash files, we empty the Trash using trash-cli
	trash-empty

	#If the backup folder is empty we want a Full backup
	if [ "$latestModifiedFile" == "" ]; then 
	
		tar -czpf /backup/fullbackup-$(date +%Y%m%d%H%M%S).tar.gz --directory=/ --exclude=dev --exclude=proc --exclude=sys --exclude=tmp --exclude=run --exclude=mnt --exclude=media --exclude=lost+found --exclude=backup .
        	log_message="Full backup"
		
	#Otherwise, we want an Incremental backup
	else

        	tar -czpf /backup/incrementalbackup-$(date +%Y%m%d%H%M%S).tar.gz --directory=/ --newer="/backup/$latestModifiedFile" --exclude=dev --exclude=proc --exclude=sys --exclude=tmp --exclude=run --exclude=mnt --exclude=media --exclude=lost+found --exclude=backup .
        	log_message="Incremental backup"

	fi

fi

#For security reasons, mount point is remounted with read only option
mount -o remount,ro /dev/sdd3 /backup

echo $log_message > /home/eric/backup_log.txt
echo $log_message done!
