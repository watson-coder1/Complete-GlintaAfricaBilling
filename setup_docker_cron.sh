#!/bin/bash

# Setup cron jobs in Docker container
echo "Setting up cron jobs in Docker container..."

# Install cron in the container
docker exec glinta-billing-web apt-get update
docker exec glinta-billing-web apt-get install -y cron

# Create crontab file
docker exec glinta-billing-web bash -c 'cat > /tmp/crontab << EOF
# Expired Cronjob Every 5 Minutes [Recommended]
*/5 * * * * cd /var/www/html/system/ && /usr/local/bin/php cron.php

# Reminder Cronjob Every 7 AM
0 7 * * * cd /var/www/html/system/ && /usr/local/bin/php cron_reminder.php
EOF'

# Install the crontab
docker exec glinta-billing-web crontab /tmp/crontab

# Start cron service
docker exec glinta-billing-web service cron start

# Enable cron to start on container restart
docker exec glinta-billing-web update-rc.d cron enable

echo "Cron jobs setup complete!"
echo "To verify, run: docker exec glinta-billing-web crontab -l"