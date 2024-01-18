#!/bin/bash

#
# Author: Srikanth Josyula
#

# Log directory
LOGDIR=/Data01/alfresco7.2/tomcat/logs
LOGBACKUPDIR=/Data01/old_logs

# Maximum FileSize of the log (in MB)
MAXFILESIZE=20

echo "Log rotation script started at "$(date '+%Y-%m-%d_%H:%M:%S')

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
      echo 'Creating Date folder' "$DATE_FOLDER"
      mkdir -p "$LOGBACKUPDIR/$DATE_FOLDER"
    fi

    # Get filename
    FILENAME=$(basename "$LOGFILE")

    # Move the files
    echo 'Moving' "$FILENAME" 'to' "$LOGBACKUPDIR/$DATE_FOLDER"
    cp "$LOGFILE" "$LOGBACKUPDIR/$DATE_FOLDER"
    sudo rm "$LOGFILE"
    mv "$LOGBACKUPDIR/$DATE_FOLDER/$FILENAME" "$LOGBACKUPDIR/$DATE_FOLDER/$FILENAME.${DATE_FOLDER}_${TIME_FOLDER}"

  fi
done

# Zipping old logs
PREVDAY=$(date --date="yesterday" +"%Y-%m-%d")
if [ -d "$LOGBACKUPDIR/$PREVDAY" ]; then
  # Compress and clear the log file
  cd "$LOGBACKUPDIR" || exit
  zip -r "$PREVDAY.zip" "$PREVDAY"

  # Clear archive folder
  echo "Deleting $LOGBACKUPDIR/$PREVDAY"
  rm -rf "$LOGBACKUPDIR/$PREVDAY"
fi

# Additional Directory Operations

# Create a folder with year/month/date in the directory
current_year=$(date '+%Y')
current_month=$(date '+%m')
current_day=$(date '+%d')

year_month_date_folder="$LOGBACKUPDIR/$current_year/$current_month/$current_day"
mkdir -p "$year_month_date_folder"

# Check the file size of Catalina logs and copy to the new folder
CATALINA_LOG="$LOGDIR/catalina.out"
CATALINA_SIZE=$(du -m "$CATALINA_LOG" | cut -f1)
if [ "$CATALINA_SIZE" -gt "$MAXFILESIZE" ]; then
  cp "$CATALINA_LOG" "$year_month_date_folder"
  sudo echo >"$CATALINA_LOG"
fi

# Set permissions to the new folder regularly
chown -R alfresco:alfresco "$year_month_date_folder"
chmod -R 775 "$year_month_date_folder"

# After 3 months, zip the folders and delete log files
zip_folder_date=$(date --date="3 months ago" +"%Y/%m/%d")
zip_folder="$LOGBACKUPDIR/$zip_folder_date"
if [ -d "$zip_folder" ]; then
  cd "$LOGBACKUPDIR" || exit
  zip -r "$zip_folder_date.zip" "$zip_folder_date"
  rm -rf "$zip_folder_date"
fi

# After 6 months, move to temp folder with a suffix
temp_suffix=$(date --date="6 months ago" +"half_yearly-%Y")
temp_folder="/path/to/temp_directory/$temp_suffix"
if [ -d "$zip_folder" ]; then
  mv "$zip_folder" "$temp_folder"
fi

# Clear any empty folders later found
find "$LOGBACKUPDIR" -type d -empty -delete

echo "Script completed successfully!"
