#!/bin/bash

#
# Author: Srikanth Josyula
#

# Log directory
LOGDIR=/Data01/alfresco7.2/tomcat/logs
LOGBACKUPDIR=/Data01/old_logs
TEMPDIR=/path/to/temp_directory

# Maximum FileSize of the log (in MB)
MAXFILESIZE=20

# Function to create date folder
create_date_folder() {
  local folder="$1/$(date '+%Y/%m/%d')"
  if [ ! -d "$folder" ]; then
    echo "Creating Date folder: $folder"
    mkdir -p "$folder"
  fi
}

# Function to move and clear log files
move_and_clear_log() {
  local logfile="$1"
  local target_folder="$2"
  local filename=$(basename "$logfile")

  echo "Moving $filename to $target_folder"
  cp "$logfile" "$target_folder"
  sudo echo >"$logfile"
  mv "$target_folder/$filename" "$target_folder/$filename.$(date '+%Y-%m-%d_%H:%M:%S')"
}

# Function to zip old logs and delete log files
zip_and_delete_logs() {
  local folder_date="$1"
  local folder="$LOGBACKUPDIR/$folder_date"

  if [ -d "$folder" ]; then
    cd "$LOGBACKUPDIR" || exit
    echo "Zipping and deleting logs in folder: $folder_date"
    zip -r "$folder_date.zip" "$folder_date"
    rm -rf "$folder_date"
  fi
}

# Function to move logs to temp folder
move_to_temp() {
  local folder_date="$1"
  local folder="$LOGBACKUPDIR/$folder_date"
  local temp_suffix=$(date --date="6 months ago" +"half_yearly-%Y")
  local temp_folder="$TEMPDIR/$temp_suffix"

  if [ -d "$folder" ]; then
    echo "Moving logs in folder $folder_date to temp folder: $temp_folder"
    mv "$folder" "$temp_folder"
  fi
}

# Function to clear empty folders
clear_empty_folders() {
  find "$LOGBACKUPDIR" -type d -empty -delete
}

# Main log rotation script
main_log_rotation() {
  echo "Log rotation script started at $(date '+%Y-%m-%d_%H:%M:%S')"

  # Process Catalina logs
  CATALINA_LOG="$LOGDIR/catalina.out"
  CATALINA_SIZE=$(du -m "$CATALINA_LOG" | cut -f1)

  if [ "$CATALINA_SIZE" -gt "$MAXFILESIZE" ]; then
    create_date_folder "$LOGBACKUPDIR"
    move_and_clear_log "$CATALINA_LOG" "$LOGBACKUPDIR/$(date '+%Y/%m/%d')"
  fi

  # Zipping old logs
  zip_and_delete_logs "$(date --date='3 months ago' +'%Y/%m/%d')"

  # Moving logs to temp folder
  move_to_temp "$(date --date='6 months ago' +'%Y/%m/%d')"

  # Clearing empty folders
  clear_empty_folders

  echo "Script completed successfully!"
}

# Execute main script
main_log_rotation
