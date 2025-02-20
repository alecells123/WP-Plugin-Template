<?php

/**
 * The plugin bootstrap file
 *
 * This file is read by WordPress to generate the plugin information in the plugin
 * admin area. This file also includes all of the dependencies used by the plugin,
 * registers the activation and deactivation functions, and defines a function
 * that starts the plugin.
 *
 * @link              https://https://github.com/alecells123
 * @since             1.0.0
 * @package           Wp_Plugin_Template
 *
 * @wordpress-plugin
 * Plugin Name:       WordPress Plugin Template
 * Plugin URI:        https://github.com/alecells123/WP-Plugin-Template
 * Description:       WordPress Plugin Template - My boilerplate for creating a WordPress plugin.
 * Version:           1.0.0
 * Author:            Alec Ellsworth
 * Author URI:        https://https://github.com/alecells123/
 * License:           GPL-2.0+
 * License URI:       http://www.gnu.org/licenses/gpl-2.0.txt
 * Text Domain:       wp-plugin-template
 * Domain Path:       /languages
 */

// If this file is called directly, abort.
if ( ! defined( 'WPINC' ) ) {
	die;
}

/**
 * Currently plugin version.
 * Start at version 1.0.0 and use SemVer - https://semver.org
 * Rename this for your plugin and update it as you release new versions.
 */
define( 'WP_PLUGIN_TEMPLATE_VERSION', '1.0.0' );

/**
 * The code that runs during plugin activation.
 * This action is documented in includes/class-wp-plugin-template-activator.php
 */
function activate_wp_plugin_template() {
	require_once plugin_dir_path( __FILE__ ) . 'includes/class-wp-plugin-template-activator.php';
	Wp_Plugin_Template_Activator::activate();
}

/**
 * The code that runs during plugin deactivation.
 * This action is documented in includes/class-wp-plugin-template-deactivator.php
 */
function deactivate_wp_plugin_template() {
	require_once plugin_dir_path( __FILE__ ) . 'includes/class-wp-plugin-template-deactivator.php';
	Wp_Plugin_Template_Deactivator::deactivate();
}

register_activation_hook( __FILE__, 'activate_wp_plugin_template' );
register_deactivation_hook( __FILE__, 'deactivate_wp_plugin_template' );

/**
 * The core plugin class that is used to define internationalization,
 * admin-specific hooks, and public-facing site hooks.
 */
require plugin_dir_path( __FILE__ ) . 'includes/class-wp-plugin-template.php';

/**
 * Begins execution of the plugin.
 *
 * Since everything within the plugin is registered via hooks,
 * then kicking off the plugin from this point in the file does
 * not affect the page life cycle.
 *
 * @since    1.0.0
 */
function run_wp_plugin_template() {

	$plugin = new Wp_Plugin_Template();
	$plugin->run();

}
run_wp_plugin_template();
