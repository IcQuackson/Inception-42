<?php
// Wait for 5 seconds (simulating sleep 5 in Bash)
sleep(5);

// Path to WordPress installation
$wpPath = '/var/www/html';

// Check if wp-config.php already exists
if (file_exists("$wpPath/wp-config.php")) {
    echo "WordPress already installed\n";
    exit(0);
}

// WordPress database configuration
define('DB_NAME', getenv('DB_NAME'));
define('DB_USER', getenv('DB_USER'));
define('DB_PASSWORD', getenv('DB_PASSWORD'));
define('DB_HOST', getenv('DB_HOST'));
define('DB_CHARSET', getenv('DB_CHARSET'));
define('DB_COLLATE', getenv('DB_COLLATE'));

// URL and site configuration
define('WP_HOME', getenv('WP_URL'));
define('WP_SITEURL', getenv('WP_URL'));
define('WP_TITLE', getenv('WP_TITLE'));
define('WP_ADMIN_USER', getenv('WP_ADMIN_USER'));
define('WP_ADMIN_PASSWORD', getenv('WP_ADMIN_PASSWORD'));
define('WP_ADMIN_EMAIL', getenv('WP_ADMIN_EMAIL'));

// Additional user configuration
$secondUser = getenv('WP_SECOND_USER');
$secondUserEmail = getenv('WP_SECOND_USER_EMAIL');
$secondUserPassword = getenv('WP_SECOND_USER_PASSWORD');

// Download WordPress core files
require_once("$wpPath/wp-load.php");

// Create wp-config.php
if (!file_exists("$wpPath/wp-config.php")) {
    require_once("$wpPath/wp-admin/includes/file.php");
    require_once("$wpPath/wp-admin/includes/misc.php");
    require_once("$wpPath/wp-admin/includes/admin.php");

    wp_config_create(
        array(
            'dbname' => DB_NAME,
            'dbuser' => DB_USER,
            'dbpassword' => DB_PASSWORD,
            'dbhost' => DB_HOST,
            'path' => $wpPath,
        )
    );

    // Install WordPress
    require_once("$wpPath/wp-admin/includes/upgrade.php");
    require_once("$wpPath/wp-admin/includes/upgrade.php");
    require_once("$wpPath/wp-admin/includes/upgrade.php");

    wp_install(
        WP_TITLE,
        WP_ADMIN_USER,
        WP_ADMIN_EMAIL,
        true,
        null,
        WP_ADMIN_PASSWORD
    );

    // Create additional user
    require_once("$wpPath/wp-includes/user.php");
    wp_create_user(
        $secondUser,
        $secondUserPassword,
        $secondUserEmail
    );

    echo "WordPress installed successfully\n";
}

// Execute other commands (like starting a web server)
exec($argv);
