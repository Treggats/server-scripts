#!/usr/bin/env bash

echo "Add update task to daily cron"
cp tasks/update.sh /etc/cron.daily/update
chmod u+x /etc/cron.daily/update
