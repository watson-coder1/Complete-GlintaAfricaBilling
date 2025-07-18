#!/bin/bash

# Billing System Cronjob Script
# Run this script every 5 minutes for expired packages check
# Run reminder script once daily

# Expired packages check (run every 5 minutes)
docker exec nuxbill php /var/www/html/system/cron.php

# Reminder notifications (run once daily at 8 AM)
# Uncomment and adjust the time as needed
# docker exec nuxbill php /var/www/html/system/cron_reminder.php