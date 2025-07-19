<?php
/**
 * Customer Login Redirect Handler
 * This file provides a direct URL for customer login access
 */

// Redirect to the proper login route
header('Location: index.php?_route=login');
exit;
?>