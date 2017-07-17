<?php
  $config = array(
    'debug' => true,
    'app_name' => 'ccdaa',
    'app_version' => '0.13.6',
    'base_url' => '/api/v1',
    'base_path' => '/var/www/ccdaa/api/v1',
    'authorized_tables' => array('authorization','sessions', 'projects', 'forms', 'questions', 'responses'),
    'post_filters' => array(''),
    'supported_params' => array('key', 'passkey', 'app_name', 'projects_id', 'languages_id', 'forms_id', 'sections_id', 'cache'),
    'restricted_fields' => array('users' => array('hashed_password', 'salt')),
    'scored_section_lu_options_id' => '13', // This is the ID of the lu_options item that is 'scored_section' category 'sections'
    'ip_authentication' => null,
    'session_expiration' => array(
      'period' => 30,
      'units' => 'minutes'
    ),
    'output_format' => 'json',
    'timezone' => 'America/New_York', //http://php.net/manual/en/timezones.php
    'lib_path' => '/var/www/ccdaa/api/v1/libs/',
    'log_path' => '/var/www/ccdaa/api/v1/logs/',
    'log_name' => 'all.log',
    'log_date_format' => 'Y-m-d H:i',
    'log_size' => '5000000', // This is the total number of bytes
    'log_advanced' => true,
    'external_command' => array(
      'command' => 'mdat',
      'name' => 'ccdaa',
      'test_parameters' => '',
      'storage_path' => './responses/mdat/'
      ),
    'storage_path' => './responses/',
    'database' => array(
      'type' => 'mysql',
      'name' => 'ccdaa',
      'username' => 'ccdaa',
      'password' => '123',
      'host' => 'localhost',
      'timezone' => 'America/New_York', //http://php.net/manual/en/timezones.php
      'dateformat' => 'Y-m-d',
      'datetimeformat' => 'Y-m-d H:i:s',
      'dateplaceholder' => '0000-00-00 00:00:00',
      'timeformat' => 'H:i:s',
      'pdo_debug_mode' => 2,
      'pdo_timeout' => 1,
      'default_limit' => 30000
    )
  );

  error_reporting(E_ALL);

  if($config['debug']) {
    ini_set('log_errors', true);
    ini_set('display_errors', true);
  } else {
    ini_set('log_errors', true);
    ini_set('display_errors', false);
  }
?>
