<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'wp_user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'wp_pass' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'l!A?*g>6fyb-`Z9RPa$q|^=JR1;;;11-aMN}Fcqtc6p+MM6?R%TLwd^v?qY!u&E9');
define('SECURE_AUTH_KEY',  'N[S3y59HS47<B2|xGk.RWyutlRr%.iKUmOVF),ADA?iw[](+9o4W!.^Z{-##Q3YG');
define('LOGGED_IN_KEY',    'R_K2k3|FY90<)lP%%HW)1@d+UwY06YXx(:WAUT5N ~5i:z@p=F+JrcoAzHfmV|?[');
define('NONCE_KEY',        's8M*8O-qh-5 Q;(>-T+T2q#@_ =JusF)/C9-(tm/.A?h0 A}C-xl:|W!cVnDS0oT');
define('AUTH_SALT',        'g_a(i)YlD!N_eZ^#iGyWjmxy%>u$;K++xEf)gI^5iutp_D=q#$~u4?*D89MeESr<');
define('SECURE_AUTH_SALT', 'i>.;K#JAS,$5>K@^J|5c.fbwc~@:)+v/lst8(m(]M+.oe+JaL?}Ad%HW=n-G7{z*');
define('LOGGED_IN_SALT',   '^qwHDpT%7UH=$_@4~>!^k=Fi,j/v<5O85d7c_g354Ya!_ac)$x+XtfO=XvdFjf%x');
define('NONCE_SALT',       'wZk:2o^I6Dz-u=_[P{yp}Aw/-Nj$a9N]Gx5%?SLfWzvP!TM++[kRp(In#-/ ceOo');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
