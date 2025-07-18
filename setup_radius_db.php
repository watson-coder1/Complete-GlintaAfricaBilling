<?php

/**
 * RADIUS Database Setup Script
 * Developed by Watsons Developers (watsonsdevelopers.com)
 * Creates necessary RADIUS tables for FreeRADIUS integration
 */

require_once 'init.php';

echo "Setting up RADIUS database tables...\n";

try {
    // Use RADIUS database configuration
    $radius_config = [
        'connection_string' => 'mysql:host=mysql;dbname=nuxbill',
        'username' => 'nuxbill',
        'password' => '12345678',
        'identifier_quote_character' => '`',
        'error_mode' => PDO::ERRMODE_EXCEPTION,
        'return_result_sets' => true,
    ];
    
    ORM::configure($radius_config, 'radius');
    
    // Test connection
    $test = ORM::for_table('radcheck', 'radius')->limit(1)->find_many();
    echo "✅ RADIUS database connection successful\n";
    
} catch (Exception $e) {
    echo "Creating RADIUS tables...\n";
    
    // Create RADIUS tables
    $sql_commands = [
        // radcheck table
        "CREATE TABLE IF NOT EXISTS `radcheck` (
            `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `username` varchar(64) NOT NULL DEFAULT '',
            `attribute` varchar(64) NOT NULL DEFAULT '',
            `op` char(2) NOT NULL DEFAULT '==',
            `value` varchar(253) NOT NULL DEFAULT '',
            PRIMARY KEY (`id`),
            KEY `username` (`username`(32))
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;",
        
        // radreply table  
        "CREATE TABLE IF NOT EXISTS `radreply` (
            `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `username` varchar(64) NOT NULL DEFAULT '',
            `attribute` varchar(64) NOT NULL DEFAULT '',
            `op` char(2) NOT NULL DEFAULT '=',
            `value` varchar(253) NOT NULL DEFAULT '',
            PRIMARY KEY (`id`),
            KEY `username` (`username`(32))
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;",
        
        // radgroupcheck table
        "CREATE TABLE IF NOT EXISTS `radgroupcheck` (
            `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `groupname` varchar(64) NOT NULL DEFAULT '',
            `attribute` varchar(64) NOT NULL DEFAULT '',
            `op` char(2) NOT NULL DEFAULT '==',
            `value` varchar(253) NOT NULL DEFAULT '',
            PRIMARY KEY (`id`),
            KEY `groupname` (`groupname`(32))
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;",
        
        // radgroupreply table
        "CREATE TABLE IF NOT EXISTS `radgroupreply` (
            `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
            `groupname` varchar(64) NOT NULL DEFAULT '',
            `attribute` varchar(64) NOT NULL DEFAULT '',
            `op` char(2) NOT NULL DEFAULT '=',
            `value` varchar(253) NOT NULL DEFAULT '',
            PRIMARY KEY (`id`),
            KEY `groupname` (`groupname`(32))
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;",
        
        // radacct table (accounting)
        "CREATE TABLE IF NOT EXISTS `radacct` (
            `radacctid` bigint(21) NOT NULL AUTO_INCREMENT,
            `acctsessionid` varchar(64) NOT NULL DEFAULT '',
            `acctuniqueid` varchar(32) NOT NULL DEFAULT '',
            `username` varchar(64) NOT NULL DEFAULT '',
            `groupname` varchar(64) NOT NULL DEFAULT '',
            `realm` varchar(64) DEFAULT '',
            `nasipaddress` varchar(15) NOT NULL DEFAULT '',
            `nasportid` varchar(15) DEFAULT NULL,
            `nasporttype` varchar(32) DEFAULT NULL,
            `acctstarttime` datetime NULL DEFAULT NULL,
            `acctupdatetime` datetime NULL DEFAULT NULL,
            `acctstoptime` datetime NULL DEFAULT NULL,
            `acctinterval` int(12) DEFAULT NULL,
            `acctsessiontime` int(12) unsigned DEFAULT NULL,
            `acctauthentic` varchar(32) DEFAULT NULL,
            `connectinfo_start` varchar(50) DEFAULT NULL,
            `connectinfo_stop` varchar(50) DEFAULT NULL,
            `acctinputoctets` bigint(20) DEFAULT NULL,
            `acctoutputoctets` bigint(20) DEFAULT NULL,
            `calledstationid` varchar(50) NOT NULL DEFAULT '',
            `callingstationid` varchar(50) NOT NULL DEFAULT '',
            `acctterminatecause` varchar(32) NOT NULL DEFAULT '',
            `servicetype` varchar(32) DEFAULT NULL,
            `framedprotocol` varchar(32) DEFAULT NULL,
            `framedipaddress` varchar(15) NOT NULL DEFAULT '',
            PRIMARY KEY (`radacctid`),
            UNIQUE KEY `acctuniqueid` (`acctuniqueid`),
            KEY `username` (`username`),
            KEY `framedipaddress` (`framedipaddress`),
            KEY `acctsessionid` (`acctsessionid`),
            KEY `acctsessiontime` (`acctsessiontime`),
            KEY `acctstarttime` (`acctstarttime`),
            KEY `acctinterval` (`acctinterval`),
            KEY `acctstoptime` (`acctstoptime`),
            KEY `nasipaddress` (`nasipaddress`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;",
        
        // radusergroup table
        "CREATE TABLE IF NOT EXISTS `radusergroup` (
            `username` varchar(64) NOT NULL DEFAULT '',
            `groupname` varchar(64) NOT NULL DEFAULT '',
            `priority` int(11) NOT NULL DEFAULT '1',
            KEY `username` (`username`(32))
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;",
        
        // nas table
        "CREATE TABLE IF NOT EXISTS `nas` (
            `id` int(10) NOT NULL AUTO_INCREMENT,
            `nasname` varchar(128) NOT NULL,
            `shortname` varchar(32) DEFAULT NULL,
            `type` varchar(30) DEFAULT 'other',
            `ports` int(5) DEFAULT NULL,
            `secret` varchar(60) DEFAULT 'secret',
            `server` varchar(64) DEFAULT NULL,
            `community` varchar(50) DEFAULT NULL,
            `description` varchar(200) DEFAULT 'RADIUS Client',
            PRIMARY KEY (`id`),
            KEY `nasname` (`nasname`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
    ];
    
    // Execute SQL commands
    foreach ($sql_commands as $sql) {
        try {
            $db = ORM::get_db();
            $db->exec($sql);
            echo "✅ Created table\n";
        } catch (Exception $e) {
            echo "❌ Error creating table: " . $e->getMessage() . "\n";
        }
    }
    
    // Add sample NAS entry for Mikrotik
    try {
        $nas_exists = ORM::for_table('nas')->where('nasname', 'mikrotik')->find_one();
        if (!$nas_exists) {
            $nas = ORM::for_table('nas')->create();
            $nas->nasname = 'mikrotik';
            $nas->shortname = 'Mikrotik';
            $nas->type = 'mikrotik';
            $nas->secret = 'radius123';
            $nas->description = 'Mikrotik Hotspot Router';
            $nas->save();
            echo "✅ Added default Mikrotik NAS entry\n";
        }
    } catch (Exception $e) {
        echo "❌ Error adding NAS entry: " . $e->getMessage() . "\n";
    }
    
    // Update config to enable RADIUS
    try {
        $config_file = '/var/www/html/config.php';
        $config_content = file_get_contents($config_file);
        
        if (strpos($config_content, '$radius_enable') === false) {
            $config_content .= "\n\n// RADIUS Configuration\n";
            $config_content .= '$radius_enable = true;' . "\n";
            $config_content .= '$radius_secret = "radius123";' . "\n";
            $config_content .= '$radius_nas_ip = "' . ($_SERVER['SERVER_ADDR'] ?? 'localhost') . '";' . "\n";
            
            file_put_contents($config_file, $config_content);
            echo "✅ Updated config.php with RADIUS settings\n";
        }
    } catch (Exception $e) {
        echo "❌ Error updating config: " . $e->getMessage() . "\n";
    }
    
    echo "\n🎉 RADIUS database setup completed!\n";
    echo "📋 Next steps:\n";
    echo "1. Configure your Mikrotik router with RADIUS settings\n";
    echo "2. Use the Mikrotik configuration generator: /mikrotik_config_generator.php\n";
    echo "3. Test RADIUS authentication\n";
    echo "4. Set up the cron job for automatic expiry: */5 * * * * php /var/www/html/radius_cron.php\n";
    
} catch (Exception $e) {
    echo "❌ Setup failed: " . $e->getMessage() . "\n";
}
?>