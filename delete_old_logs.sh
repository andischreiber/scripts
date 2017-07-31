#!/bin/bash
# delete remote syslog files older than 6 month
# 2017.04.13 Schreiber
now=$(date +"%Y-%m-%d_%H%M")
echo "Hello friend...   ¯\(°_o)/¯" >> /var/log/remotesyslog/delete_old_logs_$now.log
echo "$HOSTNAME - /root/bin/delete_old_logs.sh started..." >> /var/log/remotesyslog/delete_old_logs_$now.log
echo "$(date +"%Y-%m-%d %H:%M") A. Schreiber" >> /var/log/remotesyslog/delete_old_logs_$now.log
echo "" >> /var/log/remotesyslog/delete_old_logs_$now.log

#delete old files
echo "FILES DELETED:" >> /var/log/remotesyslog/delete_old_logs_$now.log
echo "==============" >> /var/log/remotesyslog/delete_old_logs_$now.log
find /var/log/remotesyslog/ -mtime +180 -exec rm -v '{}' \; >> /var/log/remotesyslog/delete_old_logs_$now.log

#delete empty folders
echo "" >> /var/log/remotesyslog/delete_old_logs_$now.log
echo "EMPTY FOLDERS DELETED:" >> /var/log/remotesyslog/delete_old_logs_$now.log
echo "======================" >> /var/log/remotesyslog/delete_old_logs_$now.log
find /var/log/remotesyslog/ -type d -empty -delete -print >> /var/log/remotesyslog/delete_old_logs_$now.log
echo "- EOF -" >> /var/log/remotesyslog/delete_old_logs_$now.log

echo "[$(date +"%Y-%m-%d %H:%M")] Remote Syslog files older than 6 month deleted." | mail -s "$HOSTNAME: old syslog files deleted" -a /var/log/remotesyslog/delete_old_logs_$now.log your-email@provider.de
