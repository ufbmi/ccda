  <?php

    function printAllResults($resultQuery){
      print "***********\nCREATING RAW RESULTS\n";
      $fileName = 'rawResults.csv';
      $oldResultsFile = fopen($fileName, "w") or die("Unable to open outputFile file!"); 
      foreach($resultQuery as $row) {
        fwrite($oldResultsFile, $row['subject_id']); 
        fwrite($oldResultsFile, ",");
        fwrite($oldResultsFile, $row['section']); 
        fwrite($oldResultsFile, ",");
        fwrite($oldResultsFile, $row['question']); 
        fwrite($oldResultsFile, ",");
        fwrite($oldResultsFile, $row['answer_value']);
        fwrite($oldResultsFile, "\r\n");
      }
        fclose($oldResultsFile);
        print "Process completed: Please see raw output file: ". $fileName. "\n"; 
        print("**********************\n");
    }

  class getData {
    private static $FILE_NAME = 'results.csv';

    public function __construct($init=true) {
      try {
        //Start by reading the configuration file.
        print "***********\nSTARTING PROCESS\n";
        $outputFile = fopen(self::$FILE_NAME, "w") or die("Unable to open outputFile file!"); 
        if(file_exists('../config.php')){
          $configFile = '../config.php';
        }
        else if(file_exists('config.php')){
          $configFile = 'config.php';
        }
        else {
          print "The configiuration file was not found. We will stop now. \n";
          break;
        }
        if($configFile!=""){
          $config = fopen($configFile, "r") or die("Unable to open file!");
          while(!feof($config) ) {
            $line =  fgets($config);
            sscanf(trim($line, " "),"'host' => '%s'",$host);
            sscanf(trim($line, " "),"'name' => '%s'",$dbname);
            sscanf(trim($line, " "),"'username' => '%s'",$username);
            sscanf(trim($line, " "),"'password' => '%s'",$pass);
          }
          fclose($config);
          $host = str_replace("',","",$host);
          $dbname = str_replace("',","",$dbname);
          $username = str_replace("',","",$username);
          $pass = str_replace("',","",$pass);
        }
        //Once we have the configuration we make the query.
        print "Connecting to db.\n";
        $pdo = new PDO("mysql:host=".$host.";dbname=".$dbname.";" ,$username,$pass);
        $pdo ->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        print "Connected to db.\n";
          /*
          *  Start getting all the questions. 
          */
          $selectQuestions = "
          SELECT
          az.passid AS subject_id , spt.title AS section, qpt.title AS question, apt.description AS answer_value, r.free_text AS free_text 
          FROM
          responses AS r 
          JOIN (select max(r2.id) id from responses r2 group by r2.sessions_id, r2.forms_id, r2.sections_id, r2.questions_id
          ) as last_response on last_response.id = r.id
          JOIN preferences_text AS spt ON spt.sections_id=r.sections_id AND spt.languages_id=1 
          JOIN preferences_text AS qpt ON qpt.questions_id=r.questions_id AND qpt.languages_id=1 
          LEFT JOIN preferences_text AS apt ON apt.answers_id=r.answers_id AND apt.languages_id=1 
          JOIN sessions AS s ON r.sessions_id=s.id 
          JOIN authorization as az ON s.id=az.sessions_id
          ";
          $resultQuery = $pdo->query($selectQuestions);
          /**Run this function if you want the raw results**/
          printAllResults($resultQuery);
          $resultQuery = $pdo->query($selectQuestions);
          /*************/
          $questionsArray = array();// this is where we store questions and answers.
          $subjects = array();
          $finalTable = array();
          $totalQuestions = array();
          /*Process followed:
           *First we get all the subjects.
           *Once we know the subjects we get the questions and answers and put them in an array as follow:
           *[][][] = [subject_ID][question #][Question/Answer]
           */
          foreach($resultQuery as $row) {
            $subjects[] = str_replace("," , "",$row['subject_id']);
          }
          $index = -1;
          $subjects = array_unique($subjects);
          foreach($subjects as $subject) {
            $index ++;
            $resultQuery = $pdo->query($selectQuestions);
            $innerIndex = -1;
            $questionsSubject[] =""; // we use this array to find if there are two questions that are exactly the same.
            foreach($resultQuery as $row) {
                if($row['subject_id'] == $subject){
                  //If the user has the question then add it to the array. 
                  $innerIndex++;
                  if ($row['section'] != ""){
                    $completeQuestion = $row['section'] . ": " . $row['question'];
                  }
                  else {
                    $completeQuestion = $row['question'];
                  }
                  if(in_array($completeQuestion, $questionsSubject)){
                    $completeQuestion = "POST: " . $completeQuestion;
                    $questionsSubject[] = $completeQuestion;
                  }
                  else {
                     $questionsSubject[] = $completeQuestion;
                  }
                  $answer = str_replace(",", "",$row['answer_value']);
                  $question = str_replace(",", "",$completeQuestion);
                  $question = str_replace("\n","",$question);
                  $question = str_replace("\r","",$question);
                  if ($answer != ""){ 
                    $answerArray = array($question, $answer);
                  } 
                  else {
                    $free_text =  str_replace(",", "",$row['free_text']);
                    $free_text = str_replace("\n","",$free_text);
                    $free_text = str_replace("\r","",$free_text);
                    $answerArray = array($question,$free_text );
                  }
                  $questions[$index][$innerIndex] = $answerArray;
                  $totalQuestions[] = $question;
              }
            }
            unset($questionsSubject);
          }
          $totalQuestions = array_unique($totalQuestions);
          print "Writing to csv file.\n";
          //Now start populating the file.
          fwrite($outputFile, "Subject_ID,");
          foreach($totalQuestions as $question) {
            fwrite($outputFile, $question . ",");

          }
          $totalNull = 0;
          fwrite($outputFile,"\r\n");
          $index = -1;
          foreach($subjects as $subject) {
            fwrite($outputFile, $subject . ",");
            $index++;
            foreach($totalQuestions as $question) {
            $found = 0;
             for($x = 0; $x < sizeof($questions[$index]); $x++){
                 if($question == $questions[$index][$x][0]){
                    if ($index == 1){
                     // print "got here";
                    }
                    fwrite($outputFile, $questions[$index][$x][1].",");
                    $found = 1;
                }
              }
                if($found == 0) {
                  $totalNull++;
                  fwrite($outputFile, "NULL".",");
                }
            }
            fwrite($outputFile,"\r\n");
        }
          fclose($outputFile);
          print($totalNull . "\n");
          print "Process completed. Please see output file: ". self::$FILE_NAME. "\n"; 

        }
         catch (PDOException $e) {
             print "PDO Exception!: " . $e->getMessage();
           }
        catch (Exception $e) {
          throw new Exception($e->getMessage());
        }
      }
    }
    $udb = new getData();

    ?>


