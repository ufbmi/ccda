<?php
  $host = 'localhost';
  $user = 'ccdaa';
  $database = 'ccdaa';
  $storage_directory = './json';

  $table = trim($argv[1]);

  // Command line password prompt
  echo "Password: ";
  system('stty -echo 2>/dev/null');
  $password = trim(fgets(STDIN));
  system('stty echo 2>/dev/null');

  if($table) {
    try {
      $db = new PDO("mysql:host=" . $host . ";dbname=" . $database . ';charset=UTF8',$user,$password);
      $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

      $sql = "SELECT * FROM `" . $table . "`";
      $statement = $db->prepare($sql);
      $statement->execute();

      $result = $statement->fetchAll(PDO::FETCH_ASSOC);
      if($result) {
        if(!file_exists($storage_directory)) {
          mkdir($storage_directory, true);
        }

        $result = array('table' => $table, 'rows' => $result);

        file_put_contents($storage_directory . '/' . $database . '.' . $table . '.json', json_encode($result));
      } else {
        $result = array('table' => $table, 'rows' => array());
        file_put_contents($storage_directory . '/' . $database . '.' . $table . '.json', json_encode($result));
        die('No results from query of ' . $table . "\n");
      }
    } catch(Exception $e) {
      die($e->getMessage() . "\n");
    }
  } else {
    die('No table name specified, add an argument' . "\n");
  }
?>
