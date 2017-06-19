<?php
  $host = 'localhost';
  $user = 'ccdaa';
  $database = 'ccdaa';
  $storage_directory = './json/';

  $english = null;
  $spanish = null;
  $target_object = null;
  $target_object_id = null;
  $parent_object_id = null;

  if( (isset($argv[1])) && ($argv[2]) ) {
    $english = trim($argv[1]);
    $spanish = trim($argv[2]);
  }

  if( (isset($argv[3])) && ($argv[4]) && ($argv[5])) {
    $target_object = trim($argv[3]);
    $target_object_id = trim($argv[4]);
    $parent_object_id = trim($argv[5]);
  }

  if(isset($argv[6])) {
    $mark = trim($argv[6]);
  }

  function jsonIterator($file) {
    $json_file = fopen($file, 'r');
    $json = fread($json_file, filesize($file));
    fclose($json_file);

    $jsonIterator = new RecursiveIteratorIterator(
        new RecursiveArrayIterator(json_decode($json, TRUE)),
        RecursiveIteratorIterator::SELF_FIRST);

    return $jsonIterator;
  }

  function findMyObject($jsonIterator, $target_object=null, $target_object_id=null) {
    if( ($target_object) && ($target_object_id) ) {
      foreach ($jsonIterator as $key => $val) {
        if($key === $target_object) {
          if(is_array($val)) {
            foreach($val as $objects_id) {
              if($objects_id['id'] === $target_object_id) {
                return $objects_id;
              }
            }
          }
        }
      }
    } else {
      return null;
    }
  }

  function getOptionsId($db=null, $category, $value) {
    try {
      $sql = "SELECT id FROM lu_options WHERE category='" . $category . "' AND parameter='" . $value . "'";
      $statement = $db->prepare($sql);
      $statement->execute();
      $result = $statement->fetchAll(PDO::FETCH_ASSOC);
      if($result) {
        return $result[0]['id'];
      } else {
        return null;
      }
    } catch(Exception $e) {
      die($e->getMessage() . "\n");
    }
  }

  function getTypeId($db=null, $category, $value) {
    try {
      $sql = "SELECT id FROM lu_types WHERE category='" . $category . "' AND value='" . $value . "'";
      $statement = $db->prepare($sql);
      $statement->execute();
      $result = $statement->fetchAll(PDO::FETCH_ASSOC);
      if($result) {
        return $result[0]['id'];
      } else {
        return null;
      }
    } catch(Exception $e) {
      die($e->getMessage() . "\n");
    }
  }

  // Command line password prompt
  echo "Password: ";
  system('stty -echo 2>/dev/null');
  $password = trim(fgets(STDIN));
  system('stty echo 2>/dev/null');

  if(($english) && ($spanish)) {
    try {
      $db = new PDO("mysql:host=" . $host . ";dbname=" . $database . ';charset=UTF8',$user,$password);
      $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

      if(strstr($target_object_id, ":")) {
        $ids = explode(":", $target_object_id);
        $english = findMyObject(jsonIterator($english), $target_object, $ids[0]);
        $spanish = findMyObject(jsonIterator($spanish), $target_object, $ids[1]);
      } else {
        $english = findMyObject(jsonIterator($english), $target_object, $target_object_id);
        $spanish = findMyObject(jsonIterator($spanish), $target_object, $target_object_id);
      }

      if( (is_array($english)) && (is_array($spanish)) ) {
        // Write the data to a file for safe keeping
        file_put_contents($storage_directory . 'object_match.json', json_encode(array($english, $spanish)));

        $parameters_type = $english['parameters']['type'];
        $lu_types_id = getTypeId($db, $target_object, $parameters_type);
        if($lu_types_id) {

          $output = null;
          if( ($target_object == 'sections') && ($parent_object_id) ) {
            // $query_to_run = "CALL `createNewObject`('sections', '" . $parent_object_id . "', '" . $english['title']
            //   . "', '" . $english['description'] . "', '" . $english['instructions'] . "', '" . $spanish['title']
            //   . "', '" . $spanish['description'] . "', '" . $spanish['instructions'] . "', '" . $lu_types_id . "')";
            // print($query_to_run);

            if(count($english['questions']) === count($spanish['questions'])) {
              // print(count($english['questions']) . "\n");
              // print(count($spanish['questions']) . "\n");
              for($x=0;$x<count($english['questions']);$x++) {
                $question['english'] = $english['questions'][$x];
                $question['spanish'] = $spanish['questions'][$x];
                $lu_types_id = getTypeId($db, 'questions', $question['english']['parameters']['type']);

                if(isset($question['english']['options']['display'])) {
                  $lu_options_id = getOptionsId($db, 'questions', 'display');
                  $lu_options_value = $question['english']['options']['display'];
                } else {
                  $lu_options_id = '';
                  $lu_options_value = '';
                }

                $query_to_run = "CALL `createNewObject`('questions', '" . $parent_object_id . "', '" . $question['english']['title']
                  . "', '" . $question['english']['description'] . "', '" . $question['english']['instructions'] . "', '" . $question['spanish']['title']
                  . "', '" . $question['spanish']['description'] . "', '" . $question['spanish']['instructions'] . "', '" . $lu_types_id . "','"
                  . $question['english']['sort_order'] . "','" . $lu_options_id . "','" . $lu_options_value . "');\n";
                $output .= $query_to_run . "\n";

                // for($y=0;$y<count($question['english']['answers']);$y++) {
                //   $answer['english'] = $question['english']['answers'][$y];
                //   $answer['spanish'] = $question['spanish']['answers'][$y];
                //
                //   $query_to_run = "CALL `createNewObject`('answers', '" . $parent_object_id . "', '" . $question['english']['title']
                //     . "', '" . $question['english']['description'] . "', '" . $question['english']['instructions'] . "', '" . $question['spanish']['title']
                //     . "', '" . $question['spanish']['description'] . "', '" . $question['spanish']['instructions'] . "', '" . $lu_types_id . "','"
                //     . $question['english']['sort_order'] . "','" . $lu_options_id . "','" . $lu_options_value . "');\n";
                //   print($query_to_run . "\n");
                // }
              }
            }
          } else if( ($target_object == 'questions') && ($parent_object_id) ) {
            if(count($english['answers']) === count($spanish['answers'])) {
              for($x=0;$x<count($english['answers']);$x++) {
                $answer['english'] = $english['answers'][$x];
                $answer['spanish'] = $spanish['answers'][$x];

                if(isset($mark)) {
                  for($y=$parent_object_id;$y<=$mark;$y++) {
                    $query_to_run = "CALL `createNewObject`('answers', '" . $y . "', '" . $answer['english']['display']
                      . "', '" . $answer['english']['value'] . "', '', '" . $answer['spanish']['display']
                      . "', '" . $answer['spanish']['value'] . "', '', '','"
                      . $answer['english']['sort_order'] . "','','');\n";
                    $output .= $query_to_run . "\n";
                  }
                } else {
                  $query_to_run = "CALL `createNewObject`('answers', '" . $parent_object_id . "', '" . $answer['english']['display']
                    . "', '" . $answer['english']['value'] . "', '', '" . $answer['spanish']['display']
                    . "', '" . $answer['spanish']['value'] . "', '', '','"
                    . $answer['english']['sort_order'] . "','','');\n";
                  $output .= $query_to_run . "\n";
                }
              }
            }
          }

          file_put_contents($storage_directory . 'printed_calls.json', $output);
        } else {
          print('Failed to get lu_types_id');
        }
      } else {
        print('No data');
      }

      // $sql = "SELECT * FROM `" . $table . "`";
      // $statement = $db->prepare($sql);
      // $statement->execute();
      //
      // $result = $statement->fetchAll(PDO::FETCH_ASSOC);
      // if($result) {
      //   if(!file_exists($storage_directory)) {
      //     mkdir($storage_directory, true);
      //   }
      //
      //   $result = array('table' => $table, 'rows' => $result);
      //
      //   file_put_contents($storage_directory . '/' . $database . '.' . $table . '.json', json_encode($result));
      // } else {
      //   $result = array('table' => $table, 'rows' => array());
      //   file_put_contents($storage_directory . '/' . $database . '.' . $table . '.json', json_encode($result));
      //   die('No results from query of ' . $table . "\n");
      // }



    } catch(Exception $e) {
      die($e->getMessage() . "\n");
    }
  } else {
    die('No file name specified, add arguments ($file1 $file2 $target_object $target_object_id)' . "\n");
  }
?>
