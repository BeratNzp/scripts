#!/bin/bash

###################################
# Variables
###################################
main_directory="WHICH DIRECTORY WANT TO BACKUP"
tar_file_prefix="sample_"
s3_directory="s3://your-s3-backup-bucket"

script_time="$(date)"
file_create_time="$(date +'%d-%m-%Y-%H-%M-%S')"

file_path="$tar_file_prefix-$file_create_time"

backup_system_directory="/home/$USER/backupsystem"
backup_files_directory="$backup_system_directory/backups"

mkdir -p $backup_system_directory # Make backup system directory
mkdir -p $backup_files_directory # Make backup files directory

sudo rm "$backup_files_directory/$tar_file_prefix"* # Remove old backup files

###################################
# Backup processes
###################################
backup_cron_log_file="backup-$tar_file_prefix.log"
backup_cron_log_path="$backup_system_directory/$backup_cron_log_file"
echo "-" | sudo tee -a $backup_cron_log_path
echo "[$script_time]" | sudo tee -a $backup_cron_log_path
sudo tar -zcf $backup_files_directory/$file_path.tar.gz $main_directory | sudo tee -a $backup_cron_log_path # Compress the main directory and print the log
aws s3 cp $backup_files_directory/$file_path.tar.gz $s3_directory | sudo tee -a $backup_cron_log_path # Upload the compressed file to S3 and print the log
