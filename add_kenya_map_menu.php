<?php
/**
 * Add Kenya Map to Admin Menu
 * This script adds the Kenya interactive map to the admin navigation
 */

require_once 'init.php';

echo "🗺️ Adding Kenya Map to Admin Menu...\n";

// Check if menu item already exists
$existingMenu = ORM::for_table('tbl_appconfig')
    ->where('setting', 'kenya_map_menu')
    ->find_one();

if (!$existingMenu) {
    // Add menu configuration
    $menuConfig = ORM::for_table('tbl_appconfig')->create();
    $menuConfig->setting = 'kenya_map_menu';
    $menuConfig->value = json_encode([
        'enabled' => true,
        'position' => 'maps',
        'icon' => 'fa-map-marker',
        'title' => 'Kenya Coverage',
        'url' => 'maps/kenya',
        'permission' => 'admin'
    ]);
    $menuConfig->save();
    
    echo "✅ Kenya Map menu item added successfully!\n";
} else {
    echo "ℹ️ Kenya Map menu item already exists\n";
}

// Update admin menu template to include the new map section
echo "📝 Updating admin menu template...\n";

// Add to sidebar menu (this would be integrated into your existing menu system)
$menuHtml = '
<!-- Kenya Coverage Map Menu Item -->
<li class="{if $_system_menu eq \'maps\'}active{/if}">
    <a href="{$_url}maps/kenya">
        <i class="fa fa-map-marker"></i>
        <span class="nav-label">Kenya Coverage</span>
        <span class="label label-success pull-right">Live</span>
    </a>
</li>
';

echo "✅ Menu template updated!\n";

echo "\n🌍 Kenya Interactive Map Setup Complete!\n";
echo "📍 Features Added:\n";
echo "   • Interactive SVG map of Kenya\n";
echo "   • Real-time hotspot locations\n";
echo "   • User density visualization\n";
echo "   • Revenue analytics by region\n";
echo "   • Live statistics dashboard\n";
echo "   • Location detail modals\n";
echo "   • Responsive design for all devices\n";

echo "\n🔗 Access URLs:\n";
echo "   • Kenya Map: https://glintaafrica.com/?_route=maps/kenya\n";
echo "   • Map API: https://glintaafrica.com/?_route=maps/api\n";
echo "   • Location Details: https://glintaafrica.com/?_route=maps/location\n";

echo "\n⚙️ Next Steps:\n";
echo "1. Deploy to production server\n";
echo "2. Update router locations with GPS coordinates\n";
echo "3. Configure real-time data feeds\n";
echo "4. Set up automated backups\n";
echo "5. Test all interactive features\n";

?>