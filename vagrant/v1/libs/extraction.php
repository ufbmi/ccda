    <?php 
      function createJson($resultQuery){
        print "Formatting data from db\n";
        $fileName = 'results.json';
        $resultsFile = fopen($fileName, "w") or die("Unable to open outputFile file!"); 
        $fitQuestions = ["Amount of Colon Examined" , "Accuracy", "Cost", "Complications", "Frequency", "Discomfort", "Further Testing", "Location", "Test Preparation", "Sedation", "Time", "Scientific Evidence", "Responsibilities"  ]  ;
        $fit = 0.0;
        $colo = 0.0;
        $flex = 0.0;
        $jsonArray = [];
        $currentParticipant = "";
        //Here the script will create the json file. 
        //This script is very specific for our database but a similar can be used if needed.
        foreach($resultQuery as $row){
          if (in_array($row['section'], $fitQuestions)){
            if(strpos($row['question'], "FIT:") !== false) {
              $fit = $row['answer_value'];
            }
            elseif (strpos($row['question'], "Colonoscopy:") !== false) {
             $colo = $row['answer_value'];
            }
            elseif (strpos($row['question'], "Flexible Sigmoidoscopy:") !== false) {
              $flex = $row['answer_value'];
              if ($currentParticipant === "" ) {
                  $title = "{\n\"participants\":\n[{\n";
                  fwrite($resultsFile, $title); 
                  $currentParticipant = $row['subject_id'];
                  $criteria = preg_replace('/\s+/', '', $row['section']); 
                  $questionData = "\t\"" . $criteria . "\": {\n" . "\t\t\"fit\": " . $fit . ",\n" . "\t\t\"Colo\": " . $colo .",\n" . "\t\t\"Flex\": " . $flex;
                  fwrite($resultsFile, $questionData); 
              }
              elseif( $currentParticipant !== $row['subject_id']) {
                 $break = "\n\t}\n\t},\n\t{\n";
                 fwrite($resultsFile, $break); 
                 $currentParticipant = $row['subject_id'];
                 $criteria = preg_replace('/\s+/', '', $row['section']); 
                 $questionData = "\t\"" . $criteria . "\": {\n" . "\t\t\"fit\": " . $fit . ",\n" . "\t\t\"Colo\": " . $colo .",\n" . "\t\t\"Flex\": " . $flex;
                 fwrite($resultsFile, $questionData);
              }
              else {
                $break = "\t},\n";
                fwrite($resultsFile, $break); 
                $criteria = preg_replace('/\s+/', '', $row['section']); 
                $questionData = "\t\"" . $criteria . "\": {\n" . "\t\t\"fit\": " . $fit . ",\n" . "\t\t\"Colo\": " . $colo .",\n" . "\t\t\"Flex\": " . $flex;
                fwrite($resultsFile, $questionData); 
                $break =  "\n";
                fwrite($resultsFile, $break); 
              }
            }
          }
        }
        $endFile = "\n\t}\n}]\n}";
        fwrite($resultsFile, $endFile); 
        fclose($resultsFile);
        print "\nProcess completed: Please see raw output file: ". $resultsFile. "\n"; 
        print("**********************\n");
      }

    function getData() {
        try {
          //Start by reading the configuration file.
          print "***********\nSTARTING PROCESS\n";
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
            createJson($resultQuery);

          }
           catch (PDOException $e) {
               print "PDO Exception!: " . $e->getMessage();
             }
          catch (Exception $e) {
            throw new Exception($e->getMessage());
          }
      }
      $udb = getData();

      ?>


