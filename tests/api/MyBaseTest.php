<?php
	class MyBaseTest extends PHPUnit_Framework_TestCase {

		private $config = null;
		private $fail_gracefully = null;

		public static function setUpBeforeClass() {
		}

		protected function setUp() {
			$this->fail_gracefully = './testOutput/base_fail.log';
			$config = array(
				'debug' => true,
		    'app_name' => 'ccdaa',
		    'app_version' => '0.7.1',
		    'base_url' => '/api/v1',
		    'base_path' => './',
		    'authorized_tables' => array('authorization','sessions', 'projects', 'forms', 'questions', 'responses'),
		    'post_filters' => array(''),
		    'supported_params' => array('key', 'passkey', 'app_name', 'projects_id', 'languages_id', 'forms_id', 'sections_id', 'cache'),
		    'restricted_fields' => array('users' => array('hashed_password', 'salt')),
		    'scored_section_lu_options_id' => '13', // This is the ID of the lu_options item that is 'scored_section' category 'sections'
		    'ip_authentication' => null,
		    'session_expiration' => array(
		      'period' => 30,
		      'units' => 'minutes',
					'test' => array(
						'test_period' => 40
					)
		    ),
		    'output_format' => 'json',
		    'timezone' => 'America/New_York', //http://php.net/manual/en/timezones.php
		    'lib_path' => '/var/www/ccdaa/api/v1/libs/',
		    'log_path' => './testOutput/',
		    'log_name' => 'all_mybase.log',
		    'log_date_format' => 'Y-m-d H:i',
		    'log_size' => '500000', // This is the total number of bytes
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

      $this->config = $config;
    }

		public static function tearDownAfterClass() {
			$name = 'mybase';
			$remove_logs = true;
			$path = './testOutput/test/';

			if(file_exists($path)) {
				system('/bin/rm -rf ' . escapeshellarg($path));
			}

			if($remove_logs) {
				if(file_exists('./testOutput/all_' . $name . '.log')) {
					unlink('./testOutput/all_' . $name . '.log');
				}
			}
		}

		# Method: __construct($config=null)
		# First, we need to test if the class will load
		public function test_MyBase_configSupplied() {
		    try {
        	$MyBase = new MyBase($this->config, $this->fail_gracefully);
					$this->assertEquals(true, is_array($MyBase->config));
		    } catch(Exception $e) {
					// Nothing here because the exception should not be reached
		    }
		}

		# Method: __construct($config=null)
		# Now we need to test if the script replies with no config message
		public function test_MyBase_noConfig() {
		    try {
					$MyBase = new MyBase(null, $this->fail_gracefully);
		    } catch(Exception $e) {
	        $this->assertContains('No configuration passed to MyBase Library', $e->getMessage());
		    }
		}

		# Method: arraySearch($needle, $haystack, $strict=false)
		# First we need to test and make sure the arraySearch method
		# properly matches a good match
		public function test_arraySearch_existsInArray() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$good_needle = 'good_needle';
			$haystack = array('good_needle');
			$strict = Null;
			$mybase_result = $MyBase->arraySearch($good_needle, $haystack, $strict);
			$this->assertEquals(1, $mybase_result);
		}

		# Method: arraySearch($needle, $haystack, $strict=false)
		# Then we need to test and make sure the arraySearch method
		# properly identifies a bad match
		public function test_arraySearch_doesNotExistInArray() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$bad_needle = 'bad_needle';
			$haystack = array('good_needle');
			$strict = Null;
			$mybase_result = $MyBase->arraySearch($bad_needle, $haystack, $strict);
			$this->assertEquals(0, $mybase_result);
		}

		# Method: arraySearch($min=null,$max=null, $implode=null, $glue=null)
		# First we need to test that the generateKey method can take an array
		# with a string acting as the glue, implode that array with that glue
		# and then md5 sum that string
		public function test_generateKey_takeInArrayWithGlue() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$test_string = 'test1_test2_test3';
			$test_array = array('test1', 'test2', 'test3');
			$test_glue = '_';
			$mybase_result = $MyBase->generateKey(null, null, $test_array, $test_glue);
			$md5_result = md5($test_string);
			$this->assertEquals($md5_result, $mybase_result);
		}

		# Method: generateKey($min=null,$max=null, $implode=null, $glue=null)
		# Now we need to test that the generateKey method can use the random
		# generation of a string based on a min and max number
		public function test_generateKey_withRandomNumbers() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$mybase_result = $MyBase->generateKey(5, 10, null, null);
			$md5_result = md5(rand(5, 10));
			$this->assertEquals(strlen($md5_result), strlen($mybase_result));
		}

		# Method: generateKey($min=null,$max=null, $implode=null, $glue=null)
		# Now we need to simply test that the generateKey method is returning
		# a string that is the same length as a normal md5 return
		public function test_generateKey_takeInAllNulls() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$md5_result = md5('test1_test2_test3');
			$mybase_result = $MyBase->generateKey(null, null, null, null);
			$this->assertEquals(strlen($md5_result), strlen($mybase_result));

		}

		# Method: getDateTime($date=null, $timezone=null)
		# First just run getDateTime with no input, it should return the DateTime
		# for NOW, use the list located at http://php.net/manual/en/timezones.php
		# We will substitute UTC, since the system PHP will use that by default
		public function test_getDateTime_nullInput() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$mybase_result = $MyBase->getDateTime(null, null);
			$dateTime_result = new DateTime('now', new DateTimeZone('GMT'));
			$this->assertEquals($dateTime_result, $mybase_result);
		}

		# Method: getDateTime($date=null, $timezone=null)
		# Now test with a date string entered, but no timezone
		public function test_getDateTime_dateTimeOnlyNoTimezone() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$datetime_string = '2015-08-10 13:26:40';
			$mybase_result = $MyBase->getDateTime($datetime_string, null);
			$dateTime_result = new DateTime($datetime_string, new DateTimeZone('GMT'));
			$this->assertEquals($dateTime_result, $mybase_result);
		}

		# Method: getDateTime($date=null, $timezone=null)
		# Now test with a date string entered, but no timezone
		public function test_getDateTime_allParameters() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$datetime_string = '2015-08-10 13:26:40';
			$timezone_string = 'GMT';
			$timezone = new DateTimeZone($timezone_string);

			$mybase_result = $MyBase->getDateTime($datetime_string, $timezone_string);
			$dateTime_result = new DateTime($datetime_string, $timezone);
			$this->assertEquals($dateTime_result, $mybase_result);
		}

		# Method: stringDateTime($date=null, $timezone=null, $format=null)
		# Test the method that is pretty much the same as getDateTime, except
		# that it accepts a format to be returned in and it returns a string
		# instead of a DateTime object
		public function test_stringDateTime_nullInput() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$mybase_result = $MyBase->stringDateTime(null, null, null);
			$dateTime_result = new DateTime('now', new DateTimeZone('GMT'));
			$this->assertEquals($dateTime_result->format('Y-m-d H:i:s'), $mybase_result);
		}

		# Method: stringDateTime($date=null, $timezone=null, $format=null)
		# Now test with a date string entered, but no timezone
		public function test_stringDateTime_dateTimeOnlyNoTimezone() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$datetime_string = '2015-08-10 13:26:40';
			$mybase_result = $MyBase->stringDateTime($datetime_string, null, null);
			$dateTime_result = new DateTime($datetime_string, new DateTimeZone('GMT'));
			$this->assertEquals($dateTime_result->format('Y-m-d H:i:s'), $mybase_result);
		}

		# Method: stringDateTime($date=null, $timezone=null, $format=null)
		# Now test with a date string entered, but no timezone
		public function test_stringDateTime_allParameters() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$datetime_string = '2015-08-10 13:26:40';
			$timezone_string = 'GMT';
			$timezone = new DateTimeZone($timezone_string);
			$format = 'Y-m-d H:i:s';

			$mybase_result = $MyBase->stringDateTime($datetime_string, $timezone_string, $format);
			$dateTime_result = new DateTime($datetime_string, $timezone);
			$this->assertEquals($dateTime_result->format($format), $mybase_result);
		}

		# Method: getDateTimeFromNow($period, $units, $timezone=null, $format=null, $from=null)
		# Test the method to make sure that it returns a formatted date string
		# that is the specified time period in units from the from date
		public function test_getDateTimeFromNow_nullInput() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$mybase_result = $MyBase->getDateTimeFromNow(null, null, null, null, null);
			$this->assertEquals(null, $mybase_result);
		}

		# Method: getDateTimeFromNow($period, $units, $timezone=null, $format=null, $from=null)
		# Now we test the method passing in only the time period and units, but
		# without any timezone, format, or a specified from date
		public function test_getDateTimeFromNow_withPeriodAndUnitsButNothingElse() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$period = 5;
			$units = 'days';

			$mybase_result = $MyBase->getDateTimeFromNow($period, $units, null, null, null);
			$date = new DateTime('now', new DateTimeZone('GMT'));
			date_sub($date, date_interval_create_from_date_string($period . ' ' . $units));
			$dateTime_result = date_format($date, 'Y-m-d H:i:s');
			$this->assertEquals($dateTime_result, $mybase_result);
		}

		# Method: getDateTimeFromNow($period, $units, $timezone=null, $format=null, $from=null)
		# Now we test the method passing in all parameters
		public function test_getDateTimeFromNow_allParameters() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$period = 5;
			$units = 'days';
			$format = 'Y-m-d H:i:s';
			$timezone = 'GMT';
			$from = '2015-08-10 13:59:07';

			$mybase_result = $MyBase->getDateTimeFromNow($period, $units, $timezone, $format, $from);
			$date = new DateTime($from, new DateTimeZone($timezone));
			date_sub($date, date_interval_create_from_date_string($period . ' ' . $units));
			$dateTime_result = date_format($date, $format);
			$this->assertEquals($dateTime_result, $mybase_result);
		}

		# Method: getIpAddress()
		# This method simply returns an IP address acquired from Apache
		# Since PHPUnit runs command line and not via Apache, we simply want to
		# check that there was a valid format returned
		public function test_getIpAddress_validEnvironment() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$mybase_result = $MyBase->getIpAddress();
			$http_result = '127.0.0.1';
			$this->assertEquals(count(explode('.', $http_result)), count(explode('.', $mybase_result)));
		}

		# Method: getIpAddress()
		# Now we need to test to see what happens if _SERVER['REMOTE_ADDR'] is null
		public function test_getIpAddress_noEnvironment() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$_SERVER['REMOTE_ADDR'] = null;
			$mybase_result = $MyBase->getIpAddress();
			$http_result = '127.0.0.1';
			$this->assertEquals(count(explode('.', $http_result)), count(explode('.', $mybase_result)));
		}

		# Method: makeJSONOutput($error=true, $message=null, $results=null)
		# This method makes JSON output with a specific format for the application
		# we need to check and make sure that it is valid
		public function test_makeJSONOutput_nullInput() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$mybase_result = $MyBase->makeJSONOutput(null, null, null);
			$json_result = json_encode(array("error" => null,"message" => "","count" => 0,"results" => array()));
			$this->assertEquals($json_result, $mybase_result);
		}

		# Method: makeJSONOutput($error=true, $message=null, $results=null)
		# This method makes JSON output with a specific format for the application
		# we need to check and make sure that it is valid
		public function test_makeJSONOutput_allParameters() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$error = true;
			$message = 'New Message';
			$results = array('1 Result');

			$mybase_result = $MyBase->makeJSONOutput($error, $message, $results);
			$json_result = json_encode(array("error" => $error,"message" => $message,"count" => count($results),"results" => $results, "version" => $this->config['app_version']));
			$this->assertEquals($json_result, $mybase_result);
		}

		# Method: log($data, $level, $path)
		# Test a basic log message to be logged locally in the log directory
		public function test_log_simpleEntry() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);
			$log_path = $this->config['log_path'] . $this->config['log_name'];
			$MyBase->log('object', 'method', 'test', 3, $log_path);
			$fileexists_result = file_exists($log_path);
			$this->assertEquals(true, $fileexists_result);
		}

		# Method: log($data, $level, $path)
		# Test a basic log where there is no application name specified for the log
		# to be credited to, the log method will substitute a default
		public function test_log_noAppName() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);
			$log_path = $this->config['log_path'] . $this->config['log_name'];
			$MyBase->setConfigVariable(null, 'app_name');
			$MyBase->log('object', 'method', 'test', 3, $log_path);
			$fileexists_result = file_exists($log_path);
			$this->assertEquals(true, $fileexists_result);
		}

		# Method: log($data, $level, $path)
		# Test a basic log where there is no log date format specified for the log
		# to be recorded on, the log method will substitute a default
		public function test_log_noLogDateFormat() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);
			$log_path = $this->config['log_path'] . $this->config['log_name'];
			$MyBase->setConfigVariable(null, 'log_date_format');
			$MyBase->log('object', 'method', 'test', 3, $log_path);
			$fileexists_result = file_exists($log_path);
			$this->assertEquals(true, $fileexists_result);
		}

		# Method: getConfigVariable($name=null, $sub_name_a=null, $sub_name_b=null)
		# Test the method with absolutely no input parameters specified, should
		# return null since there is none to be found
		public function test_getConfigVariable_nullInput() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$mybase_result = $MyBase->getConfigVariable(null, null, null);
			$this->assertEquals(null, $mybase_result);
		}

		# Method: getConfigVariable($name=null, $sub_name_a=null, $sub_name_b=null)
		# Test the method with one level of config variables requested
		public function test_getConfigVariable_oneLevelRequested() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$mybase_result = is_array($MyBase->getConfigVariable('session_expiration', null, null));
			$this->assertEquals(true, $mybase_result);
		}

		# Method: getConfigVariable($name=null, $sub_name_a=null, $sub_name_b=null)
		# Test the method with two levels of config variables requested
		public function test_getConfigVariable_twoLevelsRequested() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$mybase_result = $MyBase->getConfigVariable('session_expiration', 'period', null);
			$this->assertEquals('30', $mybase_result);
		}

		# Test the method with two levels of config variables requested, but that
		# level is null
		public function test_getConfigVariable_twoLevelsRequestedContainsNull() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$MyBase->setConfigVariable(null, 'session_expiration', 'period');
			$mybase_result = $MyBase->getConfigVariable('session_expiration', 'period', null);
			$this->assertEquals(null, $mybase_result);
		}

		# Method: getConfigVariable($name=null, $sub_name_a=null, $sub_name_b=null)
		# Test the method with three levels of config variables requested
		public function test_getConfigVariable_threeLevelsRequested() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);

			$mybase_result = $MyBase->getConfigVariable('session_expiration', 'test', 'test_period');
			$this->assertEquals('40', $mybase_result);
		}

		# Method: getConfigVariable($name=null, $sub_name_a=null, $sub_name_b=null)
		# Test the method with three levels of config variables requested, but that
		# level is null
		public function test_getConfigVariable_threeLevelsRequestedContainsNull() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);
			$MyBase->setConfigVariable(null, 'session_expiration', 'test', 'test_period');
			$mybase_result = $MyBase->getConfigVariable('session_expiration', 'test', 'test_period');
			$this->assertEquals(null, $mybase_result);
		}

		# Method: writeFile($path, $file, $data, $flags=null)
		# Test method with no inputs, should return null
		public function test_writeFile_nullInput() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$mybase_result = $MyBase->writeFile(null, null, null, null);
			$this->assertEquals(null, $mybase_result);
		}

		# Method: writeFile($path, $file, $data, $flags=null)
		# Test method with no inputs, should return null
		public function test_writeFile_fileAndPathNoDataOrFlags() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$file = 'test.log';
			$path = './testOutput/test/';
			if(file_exists($path)) {
				rmdir($path);
			}

			$mybase_result = $MyBase->writeFile($path, $file, null, null);
			$this->assertEquals(null, $mybase_result);
		}

		# Method: writeFile($path, $file, $data, $flags=null)
		# Test method with no inputs, should return the full path
		# if all worked as expected
		public function test_writeFile_fileAndPathWithDataNoFlags() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$file = 'test.log';
			$path = './testOutput/test/';
			system('/bin/rm -rf ' . escapeshellarg($path));
			$data = 'test data to add to the file';

			$mybase_result = $MyBase->writeFile($path, $file, $data, null);
			$this->assertEquals($path . $file, $mybase_result);
		}

		# Method: writeFile($path, $file, $data, $flags=null)
		# Test method with data and flags, should return the full path
		# if all worked as expected
		public function test_writeFile_fileAndPathWithDataAndFlags() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$file = 'test.log';
			$path = './testOutput/test/';
			$full_path = $path . $file;
			$data = 'test data to add to the file';
			$flags = FILE_APPEND;

			system('/bin/rm -rf ' . escapeshellarg($path));
			$mybase_result = $MyBase->writeFile($path, $file, $data, $flags);
			$this->assertEquals($full_path, $mybase_result);
		}

		# Method: writeFile($path, $file, $data, $flags=null)
		# Test method with all inputs, but remove the full path and make sure
		# that the response is as it would be if the path failed create_function,
		# should return null
		public function test_writeFile_fileAndPathWithDataAndFlagsTestFail() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$file = 'test.log';
			$path = './testOutput/test/';
			$full_path = $path . $file;
			$data = 'test data to add to the file';
			$flags = FILE_APPEND;

			system('/bin/rm -rf ' . escapeshellarg($path));
			$mybase_result = $MyBase->writeFile($path, $file, $data, $flags);
			system('/bin/rm -rf ' . escapeshellarg($path));
			$mybase_result = $MyBase->writeFile($path, $file, null, null);
			$this->assertEquals(null, $mybase_result);
		}

		# Method: json_validate($string)
		# Test to make sure valid json data passes the test and the return should
		# be null (no error message)
		public function test_jsonValidate_noError() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$json_data = '[{"data": "test"}]';

			$mybase_result = $MyBase->jsonValidate($json_data);
			$this->assertEquals(null, $mybase_result);
		}

		# Method: json_validate($string)
		# Test to trigger the JSON_ERROR_RECURSION error
		public function test_jsonValidate_JSONERRORRECURSION() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$json_data = '{"tests":[{"data": "test"}, {"data": "test"}]}';

			$mybase_result = $MyBase->jsonValidate($json_data);
			$this->assertEquals(null, $mybase_result);
		}

		# Method: json_validate($string)
		# Test to make sure malformed json data causes and error
		public function test_jsonValidate_JSONERRORSYNTAX() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);


			$json_data = print_r($MyBase->config, true);

			$mybase_result = $MyBase->jsonValidate($json_data);
			$this->assertEquals('Syntax error, malformed JSON.', $mybase_result);
		}
	}
?>
