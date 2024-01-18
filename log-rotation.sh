
#!/bin/bash 

#
#Author : Srikanth Josyula
#

# Log directory
LOGDIR=/Data01/alfresco7.2/tomcat/logs
LOGBACKUPDIR=/Data01/old_logs

# Maximum FileSize of the log (in MB)
MAXFILESIZE=20

echo "Log rotation script started at "$(date '+%Y-%m-%d_%H:%M:%S')

for LOGFILE in "$LOGDIR"/*;
do
  
  # Date and Time
   DATE_FOLDER=$(date '+%Y-%m-%d')
   TIME_FOLDER=$(date '+%H:%M:%S')

  #Get size in MB** 
  FILE_SIZE=`du -m $LOGFILE | tr -s '\t' ' ' | cut -d' ' -f1`

   if [ $FILE_SIZE -gt $MAXFILESIZE ];then
     
	# Check if a date folder exist
	if [ ! -d $LOGBACKUPDIR/$DATE_FOLDER ] 
	then
		# date folder doesnot exist creating one
		echo 'Creating Date folder '$DATE_FOLDER
		mkdir $LOGBACKUPDIR/$DATE_FOLDER 
	fi

	# get filename
	FILENAME=$(basename "$LOGFILE")
	
    # move the files
	echo 'Moving '$FILENAME' to '$LOGBACKUPDIR/$DATE_FOLDER
  	cp $LOGFILE $LOGBACKUPDIR/$DATE_FOLDER
	sudo echo > $LOGFILE
	mv $LOGBACKUPDIR/$DATE_FOLDER/$FILENAME $LOGBACKUPDIR/$DATE_FOLDER/$FILENAME.${DATE_FOLDER}_${TIME_FOLDER} 

   fi
done

echo "Zipping the old logs"

PREVDAY=$(date  --date="yesterday" +"%Y-%m-%d")

# check if previous day folder exists
if [ -d $LOGBACKUPDIR/$PREVDAY ] 
then
	# Compress and clear the log file
	cd $LOGBACKUPDIR
	zip -r $PREVDAY.zip $PREVDAY
		
	#clear archive folder
	echo deleting $LOGBACKUPDIR/$PREVDAY
	rm -rf $LOGBACKUPDIR/$PREVDAY
fi
