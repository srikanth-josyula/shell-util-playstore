
#!/bin/bash

#
# Author: Srikanth Josyula
#

# Log directory
LOGDIR=/Data01/alfresco7.2/tomcat/logs
LOGBACKUPDIR=/Data01/old_logs

# Maximum FileSize of the log (in MB)
MAXFILESIZE=20

echo "Log rotation script started at $(date '+%Y-%m-%d_%H:%M:%S')"

for LOGFILE in "$LOGDIR"/*; do

  # Date and Time
  DATE_FOLDER=$(date '+%Y-%m-%d')
  TIME_FOLDER=$(date '+%H:%M:%S')

  # Get size in MB
  FILE_SIZE=$(du -m "$LOGFILE" | cut -f1)

  if [ "$FILE_SIZE" -gt "$MAXFILESIZE" ]; then

    # Check if a date folder exists
    if [ ! -d "$LOGBACKUPDIR/$DATE_FOLDER" ]; then
      # Date folder does not exist; creating one
      mkdir -p "$LOGBACKUPDIR/$DATE_FOLDER"
    fi

    # Get filename
    FILENAME=$(basename "$LOGFILE")

    # Move the files
    cp "$LOGFILE" "$LOGBACKUPDIR/$DATE_FOLDER"
    sudo rm "$LOGFILE"
    mv "$LOGBACKUPDIR/$DATE_FOLDER/$FILENAME" "$LOGBACKUPDIR/$DATE_FOLDER/$FILENAME.${DATE_FOLDER}_${TIME_FOLDER}"

    # Set permissions regularly to alfresco user and 775
    chown -R alfresco:alfresco "$LOGBACKUPDIR/$DATE_FOLDER"
    chmod -R 775 "$LOGBACKUPDIR/$DATE_FOLDER"
  fi
done

echo "Zipping old logs"

PREVDAY=$(date --date="yesterday" +"%Y-%m-%d")

# Check if the previous day folder exists
if [ -d "$LOGBACKUPDIR/$PREVDAY" ]; then
  # Compress and clear the log file
  cd "$LOGBACKUPDIR" || exit
  zip -r "$PREVDAY.zip" "$PREVDAY"

  # Clear archive folder
  rm -rf "$LOGBACKUPDIR/$PREVDAY"
fi

# Additional Directory Operations

# Create year/month/date folders
YEAR=$(date '+%Y')
MONTH=$(date '+%m')
DAY=$(date '+%d')
DATE_FOLDER="$LOGBACKUPDIR/$YEAR/$MONTH/$DAY"
mkdir -p "$DATE_FOLDER"

# Check if it's been 3 months, then zip and delete old log folders
THREE_MONTHS_AGO=$(date --date="3 months ago" +"%Y-%m-%d")
if [ -d "$LOGBACKUPDIR/$THREE_MONTHS_AGO" ]; then
  cd "$LOGBACKUPDIR" || exit
  zip -r "$THREE_MONTHS_AGO.zip" "$THREE_MONTHS_AGO"
  rm -rf "$LOGBACKUPDIR/$THREE_MONTHS_AGO"
fi

# Check if it's been 6 months, then move to temp folder
SIX_MONTHS_AGO=$(date --date="6 months ago" +"%Y-%m-%d")
if [ -d "$LOGBACKUPDIR/$SIX_MONTHS_AGO" ]; then
  HALF_YEARLY_FOLDER="$LOGBACKUPDIR/temp/half_yearly-$YEAR"
  mkdir -p "$HALF_YEARLY_FOLDER"
  mv "$LOGBACKUPDIR/$SIX_MONTHS_AGO" "$HALF_YEARLY_FOLDER"
fi

# Clear any empty folders found
find "$LOGBACKUPDIR" -type d -empty -delete

echo "Script completed successfully!"
