<?php
	class MyRouteTest extends PHPUnit_Framework_TestCase {

		private $config = null;
		private $fail_gracefully = null;
		private $fake_route = null;
		private $test_method = null;

		public static function setUpBeforeClass() {
		}

    protected function setUp() {
			$this->fail_gracefully = './testOutput/base_fail.log';
			$this->fake_route = '/fake_uri';
			$this->test_method = 'letsGoTest';

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
			$name = 'myroute';
			$remove_logs = true;

			if($remove_logs) {
				if(file_exists('./testOutput/all_' . $name . '.log')) {
					unlink('./testOutput/all_' . $name . '.log');
				}
			}
		}

    # Method: __construct($config=null)
    # First, we need to test if the class will load
    public function test_MyRoute_configSupplied() {
        try {
          $MyBase = new MyBase($this->config, $this->fail_gracefully);
          $MyRoute = new MyRoute($MyBase);
          $this->assertEquals(true, is_array($MyBase->__get('config')));
        } catch(Exception $e) {
          // Nothing here because the exception should not be reached
        }
    }

    # Method: __construct($config=null)
		# Now we need to test if the script replies with no config message
		public function test_MyRoute_noConfig1() {
		    try {
          $MyBase = new MyBase(null, $this->fail_gracefully);
					$MyRoute = new MyRoute($MyBase);
		    } catch(Exception $e) {
	        $this->assertContains('No configuration passed to MyBase Library', $e->getMessage());
		    }
		}

		# Method: __construct($config=null)
		# Now we need to test if the script replies with no config message
		public function test_MyRoute_noConfig2() {
		    try {
          $MyBase = new MyBase(null, $this->fail_gracefully);
					$MyBase->setConfigVariable(null, 'config');
					$MyRoute = new MyRoute(null);
		    } catch(Exception $e) {
	        $this->assertContains('No configuration passed to MyBase Library', $e->getMessage());
		    }
		}

    # Method: __construct($config=null)
    # Test the class variables
    public function test_MyRoute_classVariables() {
      $MyBase = new MyBase($this->config, $this->fail_gracefully);
      $MyRoute = new MyRoute($MyBase);
      $this->assertEquals(array(), $MyRoute->__get('routes'));
      $this->assertEquals('/api/v1', $MyRoute->__get('base_url'));
    }

    # Method: getRouted()
    # Return the state of the current route, which will be false with a simple
    # one off run of the MyRoute library
    public function test_getRouted_noRoutes() {
      $MyBase = new MyBase($this->config, $this->fail_gracefully);
      $MyRoute = new MyRoute($MyBase);
      $myroute_result = $MyRoute->__get('routed');
      $this->assertEquals(false, $myroute_result);
    }

    # Method: getRouted()
    # Return the state of the current route, which will be false with a simple
    # one off run of the MyRoute library
    public function test_getRouted_withSingleRoute() {
      $MyBase = new MyBase($this->config, $this->fail_gracefully);
      $MyRoute = new MyRoute($MyBase);
			$MyPDO = new MyPDO($MyBase);
      $MyAPI = new MyAPI($MyBase, $MyPDO, false);
			$MyRoute->addRoute('GET', $this->fake_route, array($MyAPI, $this->test_method));
      $MyRoute->doRouting();
      $myroute_result = $MyRoute->__get('routed');
      $this->assertEquals(true, $myroute_result);
    }

    # Method: doRouting()
    # Test the routing mechanism, make sure it simply runs through and returns
    # a result of true
    public function test_doRouting_withSingleRoute() {
      $MyBase = new MyBase($this->config, $this->fail_gracefully);
      $MyRoute = new MyRoute($MyBase);
			$MyPDO = new MyPDO($MyBase);
      $MyAPI = new MyAPI($MyBase, $MyPDO, false);
			$MyRoute->addRoute('GET', $this->fake_route, array($MyAPI, $this->test_method));
      $myroute_result = $MyRoute->doRouting();
      $this->assertEquals(true, $myroute_result);
    }

    # Method: addRoute($method, $url, $callback)
    # This method adds routes to the routing object, expecting the callback
    # to be a MyAPI object type with a matching method
    public function test_addRoute_singleRoute() {
      $MyBase = new MyBase($this->config, $this->fail_gracefully);
      $MyRoute = new MyRoute($MyBase);
			$MyPDO = new MyPDO($MyBase);
      $MyAPI = new MyAPI($MyBase, $MyPDO, false);
      $MyRoute->addRoute('GET', $this->fake_route, array($MyAPI, $this->test_method));
      $myroute_result = count($MyRoute->__get('routes'));
      $this->assertEquals(1, $myroute_result);
    }

		# Method: noRoute()
		# This method is used when there is no route for the requested url
		public function test_noRoute_noRoutes() {
			$MyBase = new MyBase($this->config, $this->fail_gracefully);
      $MyRoute = new MyRoute($MyBase);
 			$myroute_result = $MyRoute->noRoute(false);
			$this->assertEquals(true, $myroute_result);
		}
  }
?>
