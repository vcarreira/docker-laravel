#!/bin/bash
touch /var/log/cron.log

rm -rf cron.d cron.hourly cron.daily cron.weekly cron.monthly

echo "mysqldump -h $DB_HOST -P $DB_PORT -u $DB_USERNAME --password=$DB_PASSWORD --single-transaction $DB_DATABASE > /mysql-backups/$DB_DATABASE-backup.sql" > /db-backup.sh
chmod +x /db-backup.sh

cron && tail -f /var/log/cron.log
