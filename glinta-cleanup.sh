#!/bin/bash

# Glinta Africa - Cron Cleanup Wrapper Script
# This script runs the cleanup tasks and updates the cron check file

LOG_FILE="/var/log/glinta-cleanup.log"
CRON_CHECK_FILE="/var/www/glintaafrica/files/cron_last_run.txt"
WEBROOT="/var/www/glintaafrica"

# Function to log messages
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $LOG_FILE
}

log_message "=== Starting Glinta cleanup tasks ==="

# Change to web directory
cd $WEBROOT

# 1. Run expired user cleanup (on host - RADIUS is on host system)
log_message "Running expired user cleanup..."
php -f radius_cleanup.php >> $LOG_FILE 2>&1
CLEANUP_EXIT_CODE=$?
log_message "Expired user cleanup exit code: $CLEANUP_EXIT_CODE"

# 2. Run authentication blocker cleanup (inside Docker)
log_message "Running authentication blocker cleanup..."
docker exec glinta-web-prod php /var/www/html/enhanced_authentication_blocker.php cleanup >> $LOG_FILE 2>&1
BLOCKER_EXIT_CODE=$?
log_message "Authentication blocker cleanup exit code: $BLOCKER_EXIT_CODE"

# 3. Run fix expired users status (inside Docker)
log_message "Running fix expired users status..."
docker exec glinta-web-prod php /var/www/html/fix_expired_users_status.php >> $LOG_FILE 2>&1
FIX_STATUS_EXIT_CODE=$?
log_message "Fix expired users status exit code: $FIX_STATUS_EXIT_CODE"

# 4. Update cron check file to prevent warning
log_message "Updating cron check file..."
echo "$(date +%s)" > $CRON_CHECK_FILE
CRON_CHECK_EXIT_CODE=$?
log_message "Cron check file update exit code: $CRON_CHECK_EXIT_CODE"

# 5. Set proper permissions
chown www-data:www-data $CRON_CHECK_FILE 2>/dev/null
chmod 664 $CRON_CHECK_FILE 2>/dev/null

log_message "=== Glinta cleanup tasks completed ==="
log_message "Summary: Cleanup=$CLEANUP_EXIT_CODE, Blocker=$BLOCKER_EXIT_CODE, FixStatus=$FIX_STATUS_EXIT_CODE, CronCheck=$CRON_CHECK_EXIT_CODE"

# Exit with success if at least cron check file was updated
if [ $CRON_CHECK_EXIT_CODE -eq 0 ]; then
    exit 0
else
    exit 1
fi