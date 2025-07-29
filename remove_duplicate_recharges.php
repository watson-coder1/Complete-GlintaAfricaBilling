<?php
/**
 * Script to remove duplicate user recharge records
 * Keeps the most recent record for each user
 */

require_once 'init.php';

echo "🔧 Starting Duplicate Recharge Cleanup - " . date('Y-m-d H:i:s') . "\n";

// Find duplicates - same username, plan, and date with multiple records
$duplicates = ORM::raw_execute("
    SELECT username, plan_id, recharged_on, COUNT(*) as duplicate_count, 
           GROUP_CONCAT(id ORDER BY recharged_time DESC) as recharge_ids
    FROM tbl_user_recharges 
    WHERE recharged_on >= '2025-07-25'
    GROUP BY username, plan_id, recharged_on 
    HAVING COUNT(*) > 1
    ORDER BY duplicate_count DESC
");

$statement = ORM::get_last_statement();
$duplicateGroups = $statement->fetchAll(PDO::FETCH_ASSOC);

echo "Found " . count($duplicateGroups) . " groups of duplicate recharges\n";

$totalRemoved = 0;
$totalKept = 0;

foreach ($duplicateGroups as $group) {
    $username = $group['username'];
    $recharge_ids = explode(',', $group['recharge_ids']);
    $duplicate_count = $group['duplicate_count'];
    
    echo "\n📋 Processing user: {$username} ({$duplicate_count} duplicates)\n";
    
    // Keep the first ID (most recent due to ORDER BY recharged_time DESC)
    $keep_id = array_shift($recharge_ids);
    echo "   ✅ Keeping recharge ID: {$keep_id}\n";
    $totalKept++;
    
    // Remove the rest
    foreach ($recharge_ids as $remove_id) {
        try {
            $recharge = ORM::for_table('tbl_user_recharges')->find_one($remove_id);
            if ($recharge) {
                $recharge->delete();
                echo "   ❌ Removed duplicate recharge ID: {$remove_id}\n";
                $totalRemoved++;
            }
        } catch (Exception $e) {
            echo "   ⚠️  Error removing recharge ID {$remove_id}: " . $e->getMessage() . "\n";
        }
    }
}

echo "\n✅ Duplicate cleanup completed - " . date('Y-m-d H:i:s') . "\n";
echo "📊 Summary:\n";
echo "   - Groups processed: " . count($duplicateGroups) . "\n";
echo "   - Records kept: {$totalKept}\n";
echo "   - Duplicates removed: {$totalRemoved}\n";

// Also clean up any duplicate RADIUS entries
echo "\n🔧 Cleaning duplicate RADIUS entries...\n";

$radiusDuplicates = ORM::raw_execute("
    SELECT username, attribute, COUNT(*) as duplicate_count,
           GROUP_CONCAT(id ORDER BY id DESC) as entry_ids
    FROM radcheck 
    WHERE username REGEXP '^[a-f0-9]{12}$'
    GROUP BY username, attribute 
    HAVING COUNT(*) > 1
", [], 'radius');

$radiusStatement = ORM::get_last_statement();
$radiusDuplicateGroups = $radiusStatement->fetchAll(PDO::FETCH_ASSOC);

echo "Found " . count($radiusDuplicateGroups) . " groups of duplicate RADIUS entries\n";

$radiusRemoved = 0;
$radiusKept = 0;

foreach ($radiusDuplicateGroups as $group) {
    $username = $group['username'];
    $attribute = $group['attribute'];
    $entry_ids = explode(',', $group['entry_ids']);
    
    // Keep the first ID (most recent)
    $keep_id = array_shift($entry_ids);
    echo "   ✅ Keeping RADIUS entry ID: {$keep_id} ({$username} - {$attribute})\n";
    $radiusKept++;
    
    // Remove the rest
    foreach ($entry_ids as $remove_id) {
        try {
            $radiusEntry = ORM::for_table('radcheck', 'radius')->find_one($remove_id);
            if ($radiusEntry) {
                $radiusEntry->delete();
                echo "   ❌ Removed duplicate RADIUS entry ID: {$remove_id}\n";
                $radiusRemoved++;
            }
        } catch (Exception $e) {
            echo "   ⚠️  Error removing RADIUS entry ID {$remove_id}: " . $e->getMessage() . "\n";
        }
    }
}

echo "\n✅ RADIUS cleanup completed\n";
echo "📊 RADIUS Summary:\n";
echo "   - RADIUS groups processed: " . count($radiusDuplicateGroups) . "\n";
echo "   - RADIUS entries kept: {$radiusKept}\n";
echo "   - RADIUS duplicates removed: {$radiusRemoved}\n";

echo "\n🎉 All cleanup completed successfully!\n";
?>