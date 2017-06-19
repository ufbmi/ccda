<?php
  include_once('./config.php');

  $phpunit_xml_path = $config['phpunit_xml_path'];
  $phpunit_file = fopen($phpunit_xml_path, 'r');
  $phpunit_data = fread($phpunit_file, filesize($phpunit_xml_path));
  fclose($phpunit_file);

  $xml_parser = xml_parser_create();
  xml_parse_into_struct($xml_parser, $phpunit_data, $vals, $index);
  xml_parser_free($xml_parser);

  try {
    $log_settings = $index[$config['custom_php_root']];

    foreach($log_settings as $key) {
      if(isset($vals[$key]['attributes']['TYPE'])) {
        $type = $vals[$key]['attributes']['TYPE'];
        if($type == 'json') {
          if(isset($vals[$key]['attributes']['TARGET'])) {
            $output_path = $vals[$key]['attributes']['TARGET'];
          }
          if(isset($vals[$key]['attributes'][$config['custom_php_tag']])) {
            $php_run = $vals[$key]['attributes'][$config['custom_php_tag']];
          }
        }
      }
    }

    if($php_run == 'true') {
      exec('phpunit --log-json ' . $output_path . ' -c ' . $phpunit_xml_path);
    }

    if(isset($output_path)) {
      if(file_exists($output_path)) {
        $json_file = fopen($output_path, 'r');
        $json_data = fread($json_file, filesize($output_path));
        fclose($json_file);

        $json_data = '['.str_replace('}{', '},' . "\n" . '{', $json_data).']';
        print($json_data);
      }
    }
  } catch(Exception $e) {
    print($e->getMessage());
  }


?>
