#!/bin/bash

# Fix Duplicate RADIUS Users Issue
# Prevents multiple RADIUS user creation for the same payment

set -e

echo "=== FIXING DUPLICATE RADIUS USERS ==="
echo "Timestamp: $(date)"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_message "🔧 Cleaning up duplicate RADIUS entries..."

# 1. Clean up duplicate radcheck entries
docker exec -i glinta-mysql-prod mysql -u root -pGlinta2025! radius << 'EOF'
-- Remove duplicate entries, keeping only the latest one for each username/attribute combination
DELETE t1 FROM radcheck t1
INNER JOIN radcheck t2 
WHERE t1.id < t2.id 
AND t1.username = t2.username 
AND t1.attribute = t2.attribute;

-- Show remaining entries
SELECT username, attribute, COUNT(*) as count 
FROM radcheck 
GROUP BY username, attribute 
HAVING count > 1;
EOF

log_message "✅ Duplicate radcheck entries cleaned"

# 2. Clean up duplicate radreply entries
docker exec -i glinta-mysql-prod mysql -u root -pGlinta2025! radius << 'EOF'
-- Remove duplicate entries from radreply
DELETE t1 FROM radreply t1
INNER JOIN radreply t2 
WHERE t1.id < t2.id 
AND t1.username = t2.username 
AND t1.attribute = t2.attribute;
EOF

log_message "✅ Duplicate radreply entries cleaned"

# 3. Check for duplicate user recharges
log_message "🔍 Checking for duplicate user recharges..."
docker exec -i glinta-mysql-prod mysql -u root -pGlinta2025! glinta_billing << 'EOF'
SELECT username, COUNT(*) as count, 
       GROUP_CONCAT(id) as recharge_ids,
       GROUP_CONCAT(recharged_on) as dates
FROM tbl_user_recharges 
WHERE status = 'on' 
GROUP BY username 
HAVING count > 1
ORDER BY count DESC;
EOF

# 4. Clean up duplicate recharges (keep the latest one per user)
log_message "🔧 Cleaning duplicate user recharges..."
docker exec -i glinta-mysql-prod mysql -u root -pGlinta2025! glinta_billing << 'EOF'
-- Mark older recharges as expired, keep only the latest one per user
UPDATE tbl_user_recharges ur1
JOIN (
    SELECT username, MAX(id) as latest_id
    FROM tbl_user_recharges 
    WHERE status = 'on'
    GROUP BY username
    HAVING COUNT(*) > 1
) ur2 ON ur1.username = ur2.username
SET ur1.status = 'off'
WHERE ur1.id != ur2.latest_id 
AND ur1.status = 'on';
EOF

log_message "✅ Duplicate user recharges cleaned"

# 5. Add unique indexes to prevent future duplicates
log_message "🔧 Adding unique constraints to prevent future duplicates..."
docker exec -i glinta-mysql-prod mysql -u root -pGlinta2025! radius << 'EOF'
-- Add unique constraint to radcheck to prevent duplicates
ALTER TABLE radcheck 
ADD UNIQUE KEY unique_user_attr (username, attribute);

-- Add unique constraint to radreply to prevent duplicates  
ALTER TABLE radreply 
ADD UNIQUE KEY unique_user_attr (username, attribute);
EOF

log_message "✅ Unique constraints added"

log_message "=== DUPLICATE CLEANUP COMPLETE ==="
log_message "🎉 Summary:"
log_message "   - Removed duplicate RADIUS entries"
log_message "   - Cleaned up duplicate user recharges"
log_message "   - Added unique constraints to prevent future duplicates"
log_message "   - This should fix the income calculation and user count issues"

echo
echo "🎉 Duplicate RADIUS users cleanup completed!"
echo "This should resolve the income and user count multiplication issues."