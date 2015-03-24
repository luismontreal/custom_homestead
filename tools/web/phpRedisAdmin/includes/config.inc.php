<?php
//Copy this file to config.inc.php and make changes to that file to customize your configuration.

$config = array(
  'servers' => array(
    array(
      'name'   => 'Extremetube', // Optional name.
      'host'   => '127.0.0.1',
      'port'   => 6380,
      'filter' => '*',
	  'flush'  => true,         // Set to true to enable the flushdb button for this instance.
      // Optional Redis authentication.
      //'auth' => 'redispasswordhere' // Warning: The password is sent in plain-text to the Redis server.
    ),
    array(
      'name'   => 'Mofosex', // Optional name.
      'host'   => '127.0.0.1',
      'port'   => 6381,
      'filter' => '*',
	  'flush'  => true,         // Set to true to enable the flushdb button for this instance.
    ),
    array(
      'name'   => 'Keezmovies', // Optional name.
      'host'   => '127.0.0.1',
      'port'   => 6379,
      'filter' => '*',
	  'flush'  => true,         // Set to true to enable the flushdb button for this instance.

    ),
    array(
      'name'   => 'PornMD', // Optional name.
      'host'   => '127.0.0.1',
      'port'   => 6383,
      'filter' => '*',
	  'flush'  => true,         // Set to true to enable the flushdb button for this instance.
    ),
	    array(
      'name'   => 'Spankwire', // Optional name.
      'host'   => '127.0.0.1',
      'port'   => 6384,
      'filter' => '*',
	  'flush'  => true,         // Set to true to enable the flushdb button for this instance.
    ),

    /*array(
      'host' => 'localhost',
      'port' => 6380
    ),*/

    /*array(
      'name'      => 'local db 2',
      'host'      => 'localhost',
      'port'      => 6379,
      'db'        => 1,             // Optional database number, see http://redis.io/commands/select
      'filter'    => 'something:*', // Show only parts of database for speed or security reasons.
      'seperator' => '/',           // Use a different seperator on this database.
      'flush'     => false,         // Set to true to enable the flushdb button for this instance.
      'charset'   => 'cp1251',      // Keys and values are stored in redis using this encoding (default utf-8).
    ),*/
  ),


  'seperator' => ':',


  // Uncomment to show less information and make phpRedisAdmin fire less commands to the Redis server. Recommended for a really busy Redis server.
  //'faster' => true,


  // Uncomment to enable HTTP authentication
  /*'login' => array(
    // Username => Password
    // Multiple combinations can be used
    'admin' => array(
      'password' => 'adminpassword',
    ),
    'guest' => array(
      'password' => '',
      'servers'  => array(1) // Optional list of servers this user can access.
    )
  ),*/


  // You can ignore settings below this point.

  'maxkeylen'           => 100,
  'count_elements_page' => 100
);

?>
