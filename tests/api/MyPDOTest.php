<?php
	class MyPDOTest extends PHPUnit_Framework_TestCase {

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
		      'units' => 'minutes'
		    ),
		    'output_format' => 'json',
		    'timezone' => 'America/New_York', //http://php.net/manual/en/timezones.php
		    'lib_path' => '/var/www/ccdaa/api/v1/libs/',
		    'log_path' => './testOutput/',
		    'log_name' => 'all_mypdo.log',
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
			$name = 'mypdo';
			$remove_logs = true;

			if($remove_logs) {
				if(file_exists('./testOutput/all_' . $name . '.log')) {
					unlink('./testOutput/all_' . $name . '.log');
				}
			}
		}

		# Method: __construct($this->config=null)
		# First, we need to test if the class will load
		public function test_MyPDO_configSupplied() {
		    try {
					$MyBase = new MyBase($this->config, $this->fail_gracefully);
        	$MyPDO = new MyPDO($MyBase);
					$this->assertEquals(true, is_array($MyBase->__get('config')));
		    } catch(Exception $e) {
					// Nothing here because the exception should not be reached
		    }
		}

		# Method: __construct($this->config=null)
		# Now we need to test if the script replies with no config message
		public function test_MyPDO_noConfig() {
		    try {
					$MyBase = new MyBase(null, $this->fail_gracefully);
					$MyPDO = new MyPDO($MyBase);
		    } catch(Exception $e) {
	        $this->assertContains('No configuration passed to MyBase Library', $e->getMessage());
		    }
		}

		# Method: __construct($this->config=null)
		# Now we need to test if the config fails when a required config item
		# is missing
		public function test_MyPDO_missingRequiredConfig() {
		    try {
					$MyBase = new MyBase($this->config, $this->fail_gracefully);

					$this->config['database']['host'] = null;
					$MyPDO = new MyPDO($MyBase);
		    } catch(Exception $e) {
					print($e->getMessage());
	        $this->assertContains('Configuration of MyPDO failed', $e->getMessage());
		    }
		}

    # Method: resetParams()
    # Test the method which resets the class variable this->params to their
    // public function test_resetParams() {
    //   $MyBase = new MyBase($this->config, $this->fail_gracefully);

    //   $MyPDO = new MyPDO($this->config, $MyBase);
		//
		// 	$MyPDO->resetParams();
		// 	$mypdo_result = $MyPDO->params['columns'];
		// 	$this->assertEquals(array(), $mypdo_result);
    // }
  }
?>
