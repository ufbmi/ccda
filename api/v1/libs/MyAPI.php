<?php
  class MyAPI {

    private $MyBase = null;
    private $MyPDO = null;

    public function __construct($MyBase=null, $MyPDO=null, $init=true) {
      try {
        if(!is_a($MyBase, 'MyBase')) {
          throw new Exception('No MyBase object passed to MyAPI');
        } else {
          $this->MyBase = $MyBase;
        }

        if(!is_a($MyPDO, 'MyPDO')) {
          throw new Exception('No MyPDO object passed to MyAPI');
        } else {
          $this->MyPDO = $MyPDO;

          $this->database_timezone = $this->MyBase->getConfigVariable('database', 'timezone');
          $this->database_dateformat = $this->MyBase->getConfigVariable('database', 'dateformat');
          $this->database_timeformat = $this->MyBase->getConfigVariable('database', 'timeformat');
          $this->database_datetimeformat = $this->MyBase->getConfigVariable('database', 'datetimeformat');
          $this->authorized_tables = $this->MyBase->getConfigVariable('authorized_tables');
          $this->post_filters = $this->MyBase->getConfigVariable('post_filters');

          # This flag will tell the MyAPI class to initialize the
          # database connection with a real MySQL server using the MyPDO
          # class. Set this to false when you init the MyPDO class inside of
          # a phpunit test suite
          if($init) {
            $this->MyPDO->init();
          }
        }

        if(!$MyBase->__get('config')) {
          throw new Exception('No configuration passed to the loaded MyBase class object');
        } else {
          $this->MyBase->logGeneral('Configured Successfully');
        }
      } catch (Exception $e) {
        throw new Exception($e->getMessage());
      }
    }

    ##
    # setAuthentication(key) This method needs to pass a return value of true.
    # It can simply return true and not do any verification (checkMatch=true) or
    # it can be asked to match the key being passed against what the key
    # should be if it was created from the same IP and same date
    #
    private function setAuthentication($key=null, $checkMatch=false, $authorization_id=null) {
      if($checkMatch) {
        $this->MyBase->logGeneral('Authorization: ' . $authorization_id . ', IP: ' . $this->MyBase->getIpAddress() . ', DateTime: ' . $this->MyBase->stringDateTime(null,null,'Y-m-d'));
        $check_key = $this->MyBase->generateKey(null, null, array($authorization_id, $this->MyBase->getIpAddress(),$this->MyBase->stringDateTime(null,null,'Y-m-d')));
        if($key == $check_key) {
          $this->MyBase->logGeneral('Checking key-to-key: (' . $key . ' => ' . $check_key . ')');
          $this->MyPDO->resetParams();
          $this->MyPDO->addParamColumns(array('id', 'sites_id', 'projects_id'));
          $clauses = array(
            $this->MyPDO->buildParamWhereClause('', 'token', 'token', '='),
            $this->MyPDO->buildParamWhereClause('AND', 'deleted_at', 'deleted_at', '='),
            $this->MyPDO->buildParamWhereClause('AND', 'expired_at', 'expired_at', '='),
          );

          $data = array(
            'token' => $key,
            'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'),
            'expired_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder')
            );

          $this->MyPDO->addParamWhereClauseGroup(array(
          	 'and_or' => '',
          	 'clauses' => $clauses
            )
          );

          $this->MyPDO->prepareQuery('select', 'sessions');
          if($this->MyPDO->runQuery($data)) {
            $data = $this->MyPDO->getAll(4);
            if(count($data) == 1) {
              $this->authentication = true;
              return $data[0];
            } else {
              $this->authentication = false;
            }
          } else {
            $this->authentication = false;
          }
        } else {
          $this->MyBase->logGeneral('Keys did not match (' . $key . ' => ' . $check_key . ')');
          $this->authentication = false;
        }
      } else {
        $this->authentication = true;
        return null;
      }
    }

    ##
    # setAuthorization(key, name)
    # Method checks for a valid token in the authorization table, based on a key & name query
    # If a record is located, the method returns the id of the authorization token and sets
    # the class variable this->authorization to true, if no record is found, returns null and
    # sets the class variable this->authorization to false
    #
    private function setAuthorization($key=null, $name=null) {
      $this->authorization = false;
      $this->MyPDO->resetParams();
      $this->MyPDO->addParamColumns(array('id', 'token', 'sites_id', 'projects_id'));
      $clauses = array(
        $this->MyPDO->buildParamWhereClause('', 'token', 'token', '='),
        $this->MyPDO->buildParamWhereClause('AND', 'name', 'name', '='),
        $this->MyPDO->buildParamWhereClause('AND', 'deleted_at', 'deleted_at', '='),
        $this->MyPDO->buildParamWhereClause('AND', 'expired_at', 'expired_at', '='),
      );

      $data = array(
        'token' => $key,
        'name' => $name,
        'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'),
        'expired_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder')
        );

      $this->MyPDO->addParamWhereClauseGroup(array(
      	 'and_or' => '',
      	 'clauses' => $clauses
        )
      );

      $this->MyPDO->prepareQuery('select', 'authorization');
      $this->MyPDO->runQuery($data);
      $data = $this->MyPDO->getAll(4);

      if(count($data) == 1) {
        $this->authorization = true;
        return $data[0];
      } else {
        return null;
      }
    }

    ##
    # letsGo()
    # A shortcut method to check the class variables this->authentication and
    # this->authorization
    #
    private function letsGo() {
      if(($this->authentication) && ($this->authorization)) {
        return true;
      } else {
        return false;
      }
    }

    # Method: letsGoTest()
    # Purpose: This method exists solely to allow for testing of the
    # routing mechanisms in the MyRoute library
    public function letsGoTest() {
      $this->authentication = true;
      $this->authorization = true;
      return $this->letsGo();
    }

    private function getKey() {
	// returns the `HTTP_KEY` or params['key']

	    if (isset($_SERVER['HTTP_KEY'])) {
		    return $_SERVER['HTTP_KEY'];
	    }

	    if ($this->getParam('key')) {
		    return $this->getParam('key');
	    }

	// throw new Exception("The `HTTP_KEY` variable is not set for the server nor is `key` received as part of the request");
	return null;
    }

    ###
    # This method collects all params from the GET arguments
    # that were passed by the angular router, they are not considered
    # GET args by PHP, so we must treat them differently
    #
    private function custom_get_args($params=null) {
      if($params) {
        $this->MyBase->logGeneral('Parsing params: ', $params);
        $params = explode('&', $params);

        $return_params = array();
        $supported_params = $this->MyBase->getConfigVariable('supported_params');
        foreach($params as $param) {
          $param = explode('=', $param);
          $match_param = $this->MyBase->arraySearch($param[0], $supported_params);
          if($match_param) {
            $return_params[$param[0]] = $param[1];
          }
        }

        return $return_params;
      }
    }

    ###
    # This method collects the POST parameters sent by the angular router,
    # ajax method, and HTTP methods
    #
    private function getPostParams() {
      if(count($_POST) > 0) {
        $this->params = $_POST;
      } else {
        $post_data = file_get_contents("php://input");
        $json_error = $this->MyBase->jsonValidate($post_data);
        if(!$json_error) {
          $this->params = json_decode($post_data, true);
        }
      }
    }

    ###
    # This is a private method used to pick out a specific parameter
    # from the this->params array
    #
    private function getParam($key) {
      if(isset($this->params[$key])) {
        return $this->params[$key];
      }

      return null;
    }

    ###
    # This method sets up the angular application with the data it nsapi_request_headers
    # to display a specific projects
    #
    public function init() {

      $key = $this->getKey();
      $this->getPostParams();
      $app_name = $this->getParam('app_name');

      if($this->MyBase->getConfigVariable('app_name') !=  $app_name) {
        $this->MyBase->respond(true, 'No site authorization with matching name. Check config.app_name in web/app/config.js. Currently set to: ' . $app_name . ' (init)', null);
        $this->MyBase->sendResponse(false, true);
      }

      $this->MyPDO->resetParams();

	// these parameters are used to do a lookup in the database
	// if the "app_name = ccdaa" the query will look like
	// 
	// 	... AND authorization.name = 'ccdaa_login_auth'
	// 
      $data = array(
        'name' => $this->MyBase->getConfigVariable('app_name') . "_login_auth",
        'token' => $key,
        'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'),
        'expired_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder')
      );

	# for debug
	# print("Call init" + $data);
	// print_r($data);
	// die();

      $query = <<<EOF
SELECT
	s.id, pt.title, pt.description
FROM
	authorization AS a
	, preferences_text AS pt
	, sites AS s
WHERE
	pt.projects_id IS NULL
	AND s.id = a.sites_id
	AND a.name = :name
	AND a.token = :token
	AND pt.sites_id = s.id
	AND s.deleted_at = :deleted_at
	AND a.deleted_at = :deleted_at
	AND a.expired_at = :expired_at
EOF;

      $this->MyPDO->prepareQuery(null, null, 0, $query);

	// print_r($this->MyPDO);
        if($this->MyPDO->runQuery($data)) {
          $this->MyBase->logGeneral('Selecting the site');
          $sites_data = $this->MyPDO->getAll(4);

          if(count($sites_data) == 1) {
            $sites_id = $sites_data[0]['id'];

            // Get the list of projects under this site
            $this->MyPDO->resetParams();
            $projects_data = $this->getProject($sites_id, null, 0, true);

            if($sites_data) {
              // Get site details, specifically the audio files for the languages
              $sites_data = $this->getDetails($sites_data, 0, $sites_id, 'sites', 'all');

              $sites_data[0]['projects'] = $projects_data;
            } else {
              $this->MyBase->respond(true, 'Projects Query Failed (init)', null);
              $this->MyBase->sendResponse(false, true);
            }

            // Get the language options for this site
            $this->MyPDO->resetParams();
            $query = 'SELECT ll.*, pl.default FROM `preferences_languages` AS pl, lu_languages AS ll WHERE pl.lu_languages_id=ll.id AND pl.projects_id IS NULL AND pl.sites_id=:sites_id';
            $data = array(
              'sites_id' => $sites_id
            );
            $this->MyPDO->prepareQuery(null, null, 0, $query);
            if($this->MyPDO->runQuery($data)) {
              $languages_data = $this->MyPDO->getAll(4);
              $sites_data[0]['preferences_languages'] = $languages_data;
            } else {
              $this->MyBase->respond(true, 'Languages Query Failed (init)', null);
              $this->MyBase->sendResponse(false, true);
            }

            // TODO: Add sound bytes from preferences_options

            $this->MyBase->respond(false, 'Site Data Collected', $sites_data);
            $this->MyBase->sendResponse(false, false);
          } else {
            $this->MyBase->respond(true,
		'[inside init method]: No site authorization with matching key. Check config.api_key in web/app/config.js. Curently set to: ' . $key, null);
            $this->MyBase->sendResponse(false, true);
          }
        } else {
          $this->MyBase->respond(true, 'Site Key Query Failed (init)', null);
          $this->MyBase->sendResponse(false, true);
        }
    }

    ##
    # Method is used to check the validity of a session passed in from the web interface
    # by the user, key should be included as a header, this key should be tied to an
    # entry into the sessions table
    #
    public function check($params=null) {
      $this->getPostParams();
      $this->MyBase->logGeneral('Making call to Authorize');

      $key = $this->getKey();
      $app_name = $this->getParam('app_name');

      $authorization_id = $this->setAuthorization($key, $app_name . '_session_token');
      $authentication_id = $this->setAuthentication($key, true, $authorization_id['id']);

      if($this->letsGo()) {
        $token = $authorization_id['token'];
        $authorization_id = $authorization_id['id'];

        $this->MyPDO->resetParams();
        $this->MyPDO->addParamColumns(array('id', 'languages_id', 'projects_id', 'sites_id'));
        $clauses = array(
          $this->MyPDO->buildParamWhereClause('', 'authorization_id', 'authorization_id', '='),
          $this->MyPDO->buildParamWhereClause('AND', 'token', 'token', '=')
        );

        $data = array(
          'authorization_id' => $authorization_id,
          'token' => $token
        );

        $this->MyPDO->addParamWhereClauseGroup(array(
          'and_or' => '',
          'clauses' => $clauses
          )
        );

        $this->MyPDO->prepareQuery('select', 'sessions');
        if($this->MyPDO->runQuery($data)) {
          $this->MyBase->logGeneral('Got a live session');
          $data = $this->MyPDO->getAll(4);
          if(count($data) == 1) {
            $this->MyBase->respond(false, 'Session is active', $data);
            $this->MyBase->sendResponse(false, false);
          } else {
            $this->MyBase->respond(true, 'Session data is not complete', null);
            $this->MyBase->sendResponse(false, true);
          }
        } else {
          $this->MyBase->respond(true, 'Session data does not match or is expired', null);
          $this->MyBase->sendResponse(false, true);
        }
      } else {
        $this->MyBase->respond(true, 'Unable to find an authorized session with this key', null);
        $this->MyBase->sendResponse(false, true);
       }
    }

    ##
    # authorize(params)
    # This method is used by the app to generate a session. Passed an array of parameters
    # which are turned into the class variable this->params, a single parameter called key
    # is extracted and checked against the authorization table to verify that a matching
    # login token is available. Upon successful location of a good token, the api will then
    # query the authorization table again, but this time for an open session token
    #
    public function authorize($params=null) {
      $this->getPostParams();
      $this->MyBase->logGeneral('Making call to Authorize');
      $this->MyBase->logGeneral(print_r($this->params, true));

      $key = $this->getKey();
      $sites_id = $this->getParam('sites_id');
      $projects_id = $this->getParam('projects_id');
      $app_name = $this->getParam('app_name');

      $authentication_id = $this->setAuthentication($key);
      $authorization_id = $this->setAuthorization($key, $app_name . '_login_auth');

      if($this->letsGo()) {
        try {
          $passid = $this->getParam('passid');
          $passkey = $this->getParam('passkey');
          $token = $this->getParam('token');

          if(($passid) && ($passkey)) {
            $this->MyPDO->resetParams();
            $this->MyPDO->addParamColumns(array('id', 'sites_id', 'projects_id'));
            $clauses = array(
              $this->MyPDO->buildParamWhereClause('', 'passid', 'passid', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'name', 'name', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'sites_id', 'sites_id', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'projects_id', 'projects_id', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'passkey', 'passkey', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'sessions_id', 'sessions_id', 'IS NULL'),
              $this->MyPDO->buildParamWhereClause('AND', 'token', 'token', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'updated_at', 'updated_at', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'expired_at', 'expired_at', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'deleted_at', 'deleted_at', '=')
            );

            $data = array(
              'passid' => $passid,
              'name' => $app_name . '_session_token',
              'sites_id' => $sites_id,
              'projects_id' => $projects_id,
              'token' => '',
              'passkey' => $passkey,
              'updated_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'),
              'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'),
              'expired_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder')
              );

            $this->MyPDO->addParamWhereClauseGroup(array(
            	 'and_or' => '',
            	 'clauses' => $clauses
              )
            );

            $this->MyPDO->prepareQuery('select', 'authorization');
            if($this->MyPDO->runQuery($data)) {
              $data = $this->MyPDO->getAll(4);
              if(count($data) == 1) {
                $authorization_id = $data[0]['id'];
                $sites_id = $data[0]['sites_id'];
                $projects_id = $data[0]['projects_id'];

                $this->MyBase->logGeneral('Data supplied for new session:', $data);

                $new_token = $this->MyBase->generateKey(null, null, array($authorization_id, $this->MyBase->getIpAddress(),$this->MyBase->stringDateTime(null,null,'Y-m-d')));
                $this->MyPDO->resetParams();
                $this->MyPDO->addParamColumns(array('token', 'authorization_id', 'ip_address', 'sites_id', 'projects_id'));
                $data = array('token' => $new_token, 'authorization_id' => $authorization_id, 'ip_address' => $this->MyBase->getIpAddress(), 'sites_id' => $sites_id, 'projects_id' => $projects_id);
                $this->MyPDO->prepareQuery('insert', 'sessions');
                if($this->MyPDO->runQuery($data)) {
                  $sessions_id = $this->MyPDO->getLastId();
                  $this->MyPDO->resetParams();
                  $this->MyPDO->addParamColumns(array('sessions_id', 'updated_at', 'token', 'sites_id', 'projects_id'));
                  $clauses = array(
                    $this->MyPDO->buildParamWhereClause('', 'id', 'authorization_id', '=')
                  );
                  $data = array('authorization_id' => $authorization_id, 'token' => $new_token, 'sessions_id' => $sessions_id, 'sites_id' => $sites_id,'projects_id' => $projects_id, 'updated_at' => $this->MyBase->stringDateTime());
                  $this->MyPDO->addParamWhereClauseGroup(array(
                  	 'and_or' => '',
                  	 'clauses' => $clauses
                    )
                  );
                  $this->MyPDO->prepareQuery('update', 'authorization');
                  if($this->MyPDO->runQuery($data)) {
                    $this->MyBase->respond(false, 'New Session Created', $data);
                    $this->MyBase->sendResponse(false, false);
                  } else {
                    $this->MyBase->respond(true, 'Unable to update authorization for this key', null);
                    $this->MyBase->sendResponse(false, true);
                  }
                } else {
                  $this->MyBase->respond(true, 'Unable to create new session for this key', null);
                  $this->MyBase->sendResponse(false, true);
                }
              } else {
                $this->MyBase->respond(true, 'Invalid passid/passkey combination', null);
                $this->MyBase->sendResponse(false, true);
              }
            } else {
              $this->MyBase->respond(true, 'No session keys available for this application', null);
              $this->MyBase->sendResponse(false, true);
            }
          } else {
            $this->MyPDO->resetParams();
            $this->MyPDO->addParamColumns(array('id','passid', 'authorization_id'));
            $clauses = array(
              $this->MyPDO->buildParamWhereClause('', 'authorization_id', 'authorization_id', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'name', 'name', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'sites_id', 'sites_id', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'projects_id', 'projects_id', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'sessions_id', 'sessions_id', 'IS NULL'),
              $this->MyPDO->buildParamWhereClause('AND', 'token', 'token', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'updated_at', 'updated_at', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'expired_at', 'expired_at', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'deleted_at', 'deleted_at', '='),
              $this->MyPDO->buildParamWhereClause('AND', 'checked_at', 'checked_at', '=')
            );

            $orderby = array(
              $this->MyPDO->buildOrderByClause('passid', 'ASC')
            );

            $data = array(
              'authorization_id' => $authorization_id['id'],
              'name' => $app_name . '_session_token',
              'sites_id' => $sites_id,
              'projects_id' => $projects_id,
              'token' => '',
              'updated_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'),
              'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'),
              'expired_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'),
              'checked_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder')
              );

            $this->MyPDO->addParamWhereClauseGroup(array(
            	 'and_or' => '',
            	 'clauses' => $clauses
              )
            );

            $this->MyPDO->addParamOrderByClause($orderby);
            $this->MyPDO->addOffsetLimit('0','1');

            $this->MyPDO->prepareQuery('select', 'authorization');
            if($this->MyPDO->runQuery($data)) {
              $return_data = $this->MyPDO->getAll(4);
    	        if(count($return_data) > 0) {

                $id = $return_data[0]['id'];

                // Put this ID on hold until it is used
                $this->MyPDO->resetParams();
                $this->MyPDO->addParamColumns(array('checked_at'));
                $clauses = array(
                  $this->MyPDO->buildParamWhereClause('', 'id', 'id', '=')
                );
                $data = array('id' => $id, 'checked_at' => $this->MyBase->stringDateTime());
                $this->MyPDO->addParamWhereClauseGroup(array(
                	 'and_or' => '',
                	 'clauses' => $clauses
                  )
                );
                $this->MyPDO->prepareQuery('update', 'authorization');
                if($this->MyPDO->runQuery($data)) {
                  $this->MyBase->respond(false, 'Get Pass ID', $return_data);
                  $this->MyBase->sendResponse(false, false);
                } else {
                  $this->MyBase->respond(true, 'Unable to update checked_at time for session id for this application', null);
                  $this->MyBase->sendResponse(false, true);
                }
              } else {
                $this->MyBase->respond(true, 'No session keys available for this application', null);
                $this->MyBase->sendResponse(false, true);
              }
            } else {
              $this->MyBase->respond(true, 'Unable to acquire active session id for this application', null);
              $this->MyBase->sendResponse(false, true);
            }
          }
        } catch(Exception $e) {
          $this->MyBase->respond(true, 'Authorization Failed', null);
          $this->MyBase->sendResponse(false, true);
        }
      } else {
        $this->MyBase->respond(true, 'Authorization Denied', null);
        $this->MyBase->sendResponse(false, true);
      }
    }

    ####
    # This method builds the JSON data for a single project
    #
    private function getProject($sites_id=null, $projects_id=null, $languages_id='0', $return=false) {
      $this->MyBase->logGeneral('Getting Project by sites_id (' . $sites_id . ') or projects_id (' . $projects_id . ')');
      $model = 'forms';
      if(isset($sites_id)) {
        $data = array(
          'object_type' => 'projects',
          'parent_type' => 'sites',
          'parent_id' => $sites_id,
          'languages_id' => $languages_id,
          'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder')
          );
        $query = 'CALL getObjectByParentId(:deleted_at,:languages_id,:object_type,:parent_type,:parent_id)';
      } else if(isset($projects_id)) {
        $data = array(
          'object_type' => 'projects',
          'object_id' => $projects_id,
          'languages_id' => $languages_id,
          'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder')
          );
        $query = 'CALL getObjectByObjectId(:deleted_at,:languages_id,:object_type,:object_id)';
      } else {
        $query = null;
        $data = null;
      }

      if(($query) && ($data)) {
        $this->MyPDO->prepareQuery(null, null, 0, $query);
        if(($sites_id) || ($projects_id)) {
          if($this->MyPDO->runQuery($data)) {
            $data = $this->MyPDO->getAll(4);
            if(count($data) > 0) {
              $project_count = 0;
              foreach($data as $project_data) {
                $data = $this->getDetails($data, $project_count, $project_data['id'], 'projects', $languages_id);
                $project_count++;
              }

              if($return) {
                return $data;
              } else {
                $this->MyBase->respond(false, 'Get ' . ucfirst($model) . ' Succeeded', $data);
                return true;
              }
            } else {
              // Could not get any data for this projects_id
              if($return) {
                return false;
              } else {
                $this->MyBase->respond(true, 'Get ' . ucfirst($model) . ' Failed (1)', null);
                return false;
              }
            }
          }
        } else {
          // No projects_id specified
          if($return) {
            $this->MyBase->respond(true, 'Get ' . ucfirst($model) . ' Failed (neither sites_id or projects_id was defined)', null);
            return false;
          } else {
            return false;
          }
        }
      } else {
        // No projects_id specified
        if($return) {
          $this->MyBase->respond(true, 'Get ' . ucfirst($model) . ' Failed (3)', null);
          return false;
        } else {
          return false;
        }
      }
    }

    ####
    # This method builds the JSON data for a single form
    #
    private function getForm() {
      $forms_id = $this->getParam('forms_id');
      $projects_id = $this->getParam('projects_id');
      $sections_id = $this->getParam('sections_id');
      $languages_id = $this->getParam('languages_id');
      $cache = $this->getParam('cache');
      $data = array(
        'languages_id' => $languages_id,
        'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder')
      );

      if($forms_id) {
          // $query = 'CALL getFormsByFormsId(:deleted_at,:languages_id,:forms_id)';
          // $data['forms_id'] = $forms_id;
          $query = 'CALL getObjectByObjectId(:deleted_at,:languages_id,:object_type,:object_id)';
          $data['object_type'] = 'forms';
          $data['object_id'] = $forms_id;
      } else if($projects_id) {
          // $query = 'CALL getFormsByProjectsId(:deleted_at,:languages_id,:projects_id)';
          // $data['projects_id'] = $projects_id;
          $query = 'CALL getObjectByParentId(:deleted_at,:languages_id,:object_type,:parent_type,:parent_id)';
          $data['object_type'] = 'forms';
          $data['parent_type'] = 'projects';
          $data['parent_id'] = $projects_id;
      }

      $this->MyPDO->prepareQuery(null, null, 0, $query);
      if($this->MyPDO->runQuery($data)) {
        $forms_data = $this->MyPDO->getAll(4);
        if(count($forms_data) > 0) {
          $forms_count = 0;

        } else {

        }
      }
    }

    ####
    # This method builds the JSON data for a single section
    #
    private function getSection() {

    }

    ####
    # This method builds the JSON data for a single question
    #
    private function getQuestion() {

    }

    private function getDetails($objects_data, $objects_count, $object_id, $object_type, $languages_id='') {
      $data = array('object_id' => $object_id, 'object_type' => $object_type, 'languages_id' => $languages_id);
      $query = 'CALL getObjectDetails(:object_id,:object_type,:languages_id)';
      $this->MyPDO->prepareQuery(null, null, 0, $query);
      if($this->MyPDO->runQuery($data)) {
          $details_data = $this->MyPDO->getAll(4);
          if(count($details_data) > 0) {
              foreach($details_data as $detail) {
                  $value = $this->trueOrFalse($detail['value']);
                  if($detail['from_table'] == 'types') {
                    if(!isset($objects_data[$objects_count]['parameters'])) {
                      $objects_data[$objects_count]['parameters'] = array();
                    }
                    $objects_data[$objects_count]['parameters'] = $this->makeDetail($objects_data[$objects_count]['parameters'], $detail['parameter'], $value);
                  } else if($detail['from_table'] == 'options') {
                    if(!isset($objects_data[$objects_count]['options'])) {
                      $objects_data[$objects_count]['options'] = array();
                    }
                    $objects_data[$objects_count]['options'] = $this->makeDetail($objects_data[$objects_count]['options'], $detail['parameter'], $value);
                  }
              }

            if($object_type == 'forms') {
              if($objects_count == 0) {
                $forms_show = true;
              } else {
                $forms_show = false;
              }

              $objects_data[$objects_count]['options']['show'] = $forms_show;
              $objects_data[$objects_count]['options']['languages_id'] = $languages_id;
            } else if($object_type == 'sections') {
              $objects_data[$objects_count]['options']['show'] = false;
            }
          } else {
            if($object_type == 'forms') {
              $objects_data[$objects_count]['options']['show'] = false;
              $objects_data[$objects_count]['options']['languages_id'] = $languages_id;

              $objects_data[$objects_count]['options']['isOpen'] = false;
              $objects_data[$objects_count]['options']['isDisabled'] = true;
            } else if($object_type == 'sections') {
              $objects_data[$objects_count]['options']['show'] = false;
              $objects_data[$objects_count]['options']['isOpen'] = false;
              $objects_data[$objects_count]['options']['isDisabled'] = true;
            }
          }
      }

      return $objects_data;
    }

    ##
    # This method is used for retrieving data from the database
    #
    public function get($model, $params=null) {
      $this->params = $this->custom_get_args($params);

      $key = $this->getKey();
      $app_name = $this->getParam('app_name');

      $authorization_id = $this->setAuthorization($key, $app_name . '_session_token');
      $authentication_id = $this->setAuthentication($key, true, $authorization_id['id']);
      // $this->authorization_id = true;
      // $this->authentication_id = true;

      if($this->letsGo()) {
        try {
          $match = $this->MyBase->arraySearch($model, $this->authorized_tables, true);
          if($match === true) {
            $post_filter = $this->MyBase->arraySearch($model, $this->post_filters, true);
            if($post_filter) {
              if(func_num_args() > 0) {
                $pass_args = func_get_args();
              } else {
                $pass_args = null;
              }

              $data = call_user_func_array(array($this, $model), $pass_args);
            } else {
              if($model == 'projects') {
                $this->MyPDO->resetParams();
                $projects_id = $this->getParam('projects_id');
                $languages_id = $this->getParam('languages_id');
                $this->getProject(null, $projects_id, $languages_id, false);
                $this->MyBase->sendResponse();
              } else if($model == 'forms') {
                $this->MyPDO->resetParams();

                $forms_id = $this->getParam('forms_id');
                $projects_id = $this->getParam('projects_id');
                $sections_id = $this->getParam('sections_id');
                $languages_id = $this->getParam('languages_id');
                $cache = $this->getParam('cache');
                $data = array(
                  'languages_id' => $languages_id,
                  'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder')
                );

                if($forms_id) {
                    // $query = 'CALL getFormsByFormsId(:deleted_at,:languages_id,:forms_id)';
                    // $data['forms_id'] = $forms_id;
                    $query = 'CALL getObjectByObjectId(:deleted_at,:languages_id,:object_type,:object_id)';
                    $data['object_type'] = 'forms';
                    $data['object_id'] = $forms_id;
                } else if($projects_id) {
                    // $query = 'CALL getFormsByProjectsId(:deleted_at,:languages_id,:projects_id)';
                    // $data['projects_id'] = $projects_id;
                    $query = 'CALL getObjectByParentId(:deleted_at,:languages_id,:object_type,:parent_type,:parent_id)';
                    $data['object_type'] = 'forms';
                    $data['parent_type'] = 'projects';
                    $data['parent_id'] = $projects_id;
                }

                $this->MyPDO->prepareQuery(null, null, 0, $query);
                if($this->MyPDO->runQuery($data)) {
                    $forms_data = $this->MyPDO->getAll(4);
                    if(count($forms_data) > 0) {
                      $forms_count = 0;
                      foreach($forms_data as $form) {
                        $forms_id = $form['id'];

                        $this->MyPDO->resetParams();
                        $forms_data = $this->getDetails($forms_data, $forms_count, $forms_id, 'forms', $languages_id);

                        $this->MyPDO->resetParams();
                        // $data = array('forms_id' => $forms_id, 'languages_id' => $languages_id, 'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'));
                        // $query = 'CALL getSectionsByFormsId(:deleted_at,:languages_id,:forms_id)';
                        $data = array('parent_type' => 'forms', 'parent_id' => $forms_id, 'object_type' => 'sections', 'languages_id' => $languages_id, 'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'));
                        $query = 'CALL getObjectByParentId(:deleted_at,:languages_id,:object_type,:parent_type,:parent_id)';

                        $this->MyPDO->prepareQuery(null, null, 0, $query);
                        if($this->MyPDO->runQuery($data)) {
                          $sections_data = $this->MyPDO->getAll(4);

                          $sections_count = 0;
                          foreach($sections_data as $section) {
                            $sections_id = $section['id'];

                            $this->MyPDO->resetParams();
                            $sections_data = $this->getDetails($sections_data, $sections_count, $sections_id, 'sections', $languages_id);

                            $this->MyPDO->resetParams();
                            // $data = array('sections_id' => $sections_id, 'languages_id' => $languages_id, 'deleted_at'=>$this->MyBase->getConfigVariable('database', 'dateplaceholder'));
                            // $query = 'CALL getQuestionsBySectionsId(:deleted_at,:languages_id,:sections_id)';
                            $data = array('parent_type' => 'sections', 'parent_id' => $sections_id, 'object_type' => 'questions', 'languages_id' => $languages_id, 'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'));
                            $query = 'CALL getObjectByParentId(:deleted_at,:languages_id,:object_type,:parent_type,:parent_id)';

                            $this->MyPDO->prepareQuery(null, null, 0, $query);
                            if($this->MyPDO->runQuery($data)) {
                              $questions_data = $this->MyPDO->getAll(4);

                              $questions_count = 0;
                              $questions_counter = 1;
                              foreach($questions_data as $question) {
                                $questions_id = $question['id'];

                                $this->MyPDO->resetParams();
                                $questions_data = $this->getDetails($questions_data, $questions_count, $questions_id, 'questions', $languages_id);

                                $parameter_type = $questions_data[$questions_count]['parameters']['type'];
                                if(($parameter_type != 'matrix_headers') && ($parameter_type != 'table') && ($parameter_type != 'unordered_list')) {
                                  $questions_data[$questions_count]['counter'] = $questions_counter;
                                  $questions_counter++;
                                }

                                $this->MyPDO->resetParams();
                                // $data = array('questions_id' => $questions_id, 'languages_id' => $languages_id, 'deleted_at'=>$this->MyBase->getConfigVariable('database', 'dateplaceholder'));
                                // $query = 'CALL getAnswersByQuestionsId(:deleted_at,:languages_id,:questions_id)';
                                $data = array('parent_type' => 'questions', 'parent_id' => $questions_id, 'object_type' => 'answers', 'languages_id' => $languages_id, 'deleted_at' => $this->MyBase->getConfigVariable('database', 'dateplaceholder'));
                                $query = 'CALL getObjectByParentId(:deleted_at,:languages_id,:object_type,:parent_type,:parent_id)';

                                $this->MyPDO->prepareQuery(null, null, 0, $query);
                                if($this->MyPDO->runQuery($data)) {
                                  $answers_data = $this->MyPDO->getAll(4);
                                  $questions_data[$questions_count]['answers'] = $answers_data;
                                } else {
                                  $this->MyBase->respond(true, 'Get ' . ucfirst($model) . ' Failed. No answers data (get)', null);
                                  $this->MyBase->sendResponse(false, true);
                                }
                                $questions_count++;
                              }

                              $sections_data[$sections_count]['questions'] = $questions_data;
                            } else {
                              $this->MyBase->respond(true, 'Get ' . ucfirst($model) . ' Failed. No questions data (get)', null);
                              $this->MyBase->sendResponse(false, true);
                            }
                            $sections_count++;
                          }
                          $forms_data[$forms_count]['sections'] = $sections_data;
                        } else {
                          $this->MyBase->respond(true, 'Get ' . ucfirst($model) . ' Failed. No section data (get)', null);
                          $this->MyBase->sendResponse(false, true);
                        }
                        $forms_count++;
                      }

                      $this->MyBase->respond(false, 'Get ' . ucfirst($model) . ' Succeeded', $forms_data);
                      $output_data = $this->MyBase->getResponse();

                      if($cache) {
                        $this->MyBase->logGeneral('Writing Cached App/Project/Language: (' . $app_name . '_' . $projects_id . '_' . $languages_id . ')');
                        $this->MyBase->logGeneral('Working in: ' . getcwd());
                        $write_to_file = $this->MyBase->writeFile('./', $app_name . '_' . $projects_id . '_' . $languages_id . '.json', $output_data);
                        $this->MyBase->logGeneral('Writing to ' . $write_to_file);
                      }

                      $this->MyBase->sendResponse(false, false);
                    } else {
                      $this->MyBase->respond(true, 'Get ' . ucfirst($model) . ' Failed. Form Count: 0 (get)', null);
                      $this->MyBase->sendResponse(false, true);
                    }
                } else {
                  $this->MyBase->respond(true, 'Get ' . ucfirst($model) . ' Failed (get)', null);
                  $this->MyBase->sendResponse(false, true);
                }
              }
            }
          }
        } catch(Exception $e) {
          $this->MyBase->respond(true, 'Get ' . ucfirst($model) . ' Failed', null);
          $this->MyBase->sendResponse(false, true);
        }
      } else {
        $this->MyBase->respond(true, 'Get ' . ucfirst($model) . ' Denied', null);
        $this->MyBase->sendResponse(false, true);
      }
    }

    ###
    # This method converts the text strings TRUE/FALSE to either
    # true or false
    #
    private function trueOrFalse($data) {
      // Change the value from text 'true' to TRUE/FALSE
      if(($data === 'true') || ($data === 'false')) {
          $value = $data === 'true'? true: false;
      } else {
          $value = $data;
      }

      return $value;
    }

    ###
    # This method is used during buildouts from the details tables
    # (preferences_text, preferences_types, preferences_options)
    # It adds members to an array and expands that array or leaves the variable
    # single value if there are not more than one
    #
    private function makeDetail($array, $parameter, $value) {
      $value = $this->trueOrFalse($value);
      if(isset($array[$parameter])) {
        if(is_array($array[$parameter])) {
          $this->MyBase->logGeneral($parameter . ' already has an array');
          $this->MyBase->logGeneral('Pushing ' . $value . ' to ' . $parameter . ' array ');
          array_push($array[$parameter], $value);
        } else {
          $this->MyBase->logGeneral('Adding first index ' . $value . ' to ' . $parameter . ' array ');
          $array[$parameter] = array($array[$parameter], $value);
        }
      } else {
        $this->MyBase->logGeneral('Adding single value ' . $value . ' to ' . $parameter . ' array ');
        $array[$parameter] = $value;
      }

      return $array;
    }

    ##
    # This method is used for updating data into the database
    #
    public function update($model, $params=null) {
      $this->getPostParams();

      $key = $this->getKey();
      $app_name = $this->getParam('app_name');

      $authorization_id = $this->setAuthorization($key, $app_name . '_session_token');
      $this->MyBase->logGeneral('Authorization Reply: ' . print_r($authorization_id, true));
      $authentication_id = $this->setAuthentication($key, true, $authorization_id['id']);
      $this->MyBase->logGeneral('Authentication Reply: ' . print_r($authentication_id, true));

      if($this->letsGo()) {
        try {
          $match = $this->MyBase->arraySearch($model, $this->authorized_tables, true);
          if($match) {
            $this->MyPDO->resetParams();
            if($model == 'sessions') {
              $sessions_id = $authentication_id['id'];
              $projects_id = $authentication_id['projects_id'];
              $this->MyPDO->addParamColumns(array('languages_id', 'updated_at', 'projects_id'));
              $clauses = array(
                $this->MyPDO->buildParamWhereClause('', 'id', 'sessions_id', '=')
              );
              $data = array('sessions_id' => $sessions_id, 'languages_id' => $this->getParam('languages_id'), 'updated_at' => $this->MyBase->stringDateTime(), 'projects_id' => $projects_id);
              $this->MyPDO->addParamWhereClauseGroup(array(
              	 'and_or' => '',
              	 'clauses' => $clauses
                )
              );
              $this->MyPDO->prepareQuery('update', 'sessions');
              if($sessions_id) {
                if($this->MyPDO->runQuery($data)) {
                  $this->MyBase->respond(false, 'Update ' . ucfirst($model) . ' Succeeded', $data);
                  $this->MyBase->sendResponse(false, false);
                }
              } else {
                $this->MyBase->respond(true, 'Update ' . ucfirst($model) . ' Failed', null);
                $this->MyBase->sendResponse(false, true);
              }
            } else if ($model == 'responses') {
              $this->MyBase->logGeneral('Setting Response Data');
              $answer_data = $this->getParam('answer_data');
              $answer_data_print = print_r($answer_data, true);

              try {

                $header_data = $answer_data['header'];
                $session_token = $header_data['session'];
                $forms_id = $header_data['forms_id'];
                $sections_id = $header_data['sections_id'];
                $languages_id = $header_data['languages_id'];

                $external_data = null;
                if(isset($header_data['external_data'])) {
                  $external_data = $header_data['external_data'];
                }

                $this->MyBase->logGeneral('Processing Data for Session: ' . $session_token);

                // We need to make sure the directory for storing responses
                // and data from the external source has a filesystem location
                // to store as a backup to the database insert commands
                $responses_storage_path = $this->MyBase->getConfigVariable('storage_path');
                if (!file_exists($responses_storage_path)) {
                  mkdir($responses_storage_path);
                }

                // Write the session data to a backup file
                $this->MyBase->logGeneral('Writing Backup Data for Session: ' . $session_token);
                $this->MyBase->logGeneral('Working in: ' . getcwd());
                $write_to_file = $this->MyBase->writeFile($responses_storage_path, $session_token . '.json', json_encode($answer_data) . "\n", FILE_APPEND | LOCK_EX);
                $this->MyBase->logGeneral('Writing to ' . $write_to_file);

                $this->MyPDO->addParamColumns(array('id','sites_id', 'projects_id'));
                $clauses = array(
                  $this->MyPDO->buildParamWhereClause('', 'token', 'token', '=')
                );

                $data = array(
                  'token' => $session_token
                  );

                $this->MyPDO->addParamWhereClauseGroup(array(
                	 'and_or' => '',
                	 'clauses' => $clauses
                  )
                );

                $this->MyPDO->addOffsetLimit('0','1');
                $this->MyPDO->prepareQuery('select', 'sessions');
                if($this->MyPDO->runQuery($data)) {
                  $return_data = $this->MyPDO->getAll(4);
        	        if(count($return_data) == 1) {
                    foreach($answer_data as $question => $answer) {
                      $sessions_id = $return_data[0]['id'];
                      $scored_section_lu_options_id = $this->MyBase->getConfigVariable('scored_section_lu_options_id');
                      if((count($answer) > 0) && ($question != 'header')) {
                        $sites_id = $return_data[0]['sites_id'];
                        $projects_id = $return_data[0]['projects_id'];

                        if(!$answer['key']) {
                          $freetext = $answer['value'];
                        } else {
                          $freetext = null;
                        }

                        $this->MyBase->logGeneral('Processing (' . $question . ')' . print_r($answer, true));
                        $this->MyPDO->resetParams();
                        $this->MyPDO->addParamColumns(array('sessions_id','languages_id', 'sites_id', 'projects_id', 'forms_id', 'sections_id', 'questions_id','answers_id', 'free_text'));
                        $data = array(
                          'sessions_id' => $sessions_id,
                          'languages_id' => $languages_id,
                          'sites_id' => $sites_id,
                          'projects_id' => $projects_id,
                          'forms_id' => $forms_id,
                          'sections_id' => $sections_id,
                          'questions_id' => $question,
                          'answers_id' => $answer['key'],
                          'free_text' => $freetext
                        );
                        $this->MyPDO->prepareQuery('insert', 'responses');
                        if($this->MyPDO->runQuery($data)) {
                          $responses_id = $this->MyPDO->getLastId();
                          $output_data['count'] = $responses_id;
                          $this->MyBase->logGeneral('Saving Response: (' . $responses_id . ')');
                        }
                      } else {
                        $this->MyBase->logGeneral('Skipping (' . $question . ')');
                      }
                    }

                    // If the Angular application has indicated that the section
                    // being submitted is intending on getting data from an external
                    // command, then act on that data by using the external_data
                    // flag in the header_data
                    $external_data_returned = array();
                    if($external_data) {
                      $external_command = $this->MyBase->getConfigVariable('external_command');
                      $command_name = $external_command['name'];
                      $command_command = $external_command['command'];
                      $command_test_parameters = $external_command['test_parameters'];
                      $external_storage_path = $external_command['storage_path'];

                      if (!file_exists($external_storage_path)) {
                        mkdir($external_storage_path);
                      }

                      $this->MyBase->logGeneral('Processing Data for ' . $command_name);
                      $external_data_returned['parameters'] = $external_data;
                      $external_data_returned['accessed'] = true;

                      // We need to make an input file for the external command
                      if((isset($external_data['scored_section'])) && (count($external_data['scored_section']) > 0)) {
                        foreach($external_data['scored_section'] as $scored_key => $scored_sections_id) {
                          $this->MyBase->logGeneral('Collecting section [' . $scored_sections_id . ']');

                          $prepared_score = array();
                          $write_to_file = null;

                          $this->MyPDO->resetParams();
                          $data = array('sessions_id' => $sessions_id, 'scored_section_lu_options_id' => $scored_section_lu_options_id);
                          $query = 'CALL getScores(:sessions_id,:scored_section_lu_options_id)';
                          $this->MyPDO->prepareQuery(null, null, 0, $query);
                          if($this->MyPDO->runQuery($data)) {
                            $scores_data = $this->MyPDO->getAll(4);
                            $strip_these_strings = array(":");
                            if(count($scores_data) > 0) {
                              foreach($scores_data as $score_data) {
                                $section_title = trim($this->commandStrips($strip_these_strings, $score_data['section']));
                                $question_title = trim($this->commandStrips($strip_these_strings, $score_data['question']));
                                $score = $score_data['score'];

                                $prepared_score[$section_title][$question_title] = $score;
                              }

                              $this->MyBase->logGeneral('Writing Cached data before sending to MDAT');
                              $this->MyBase->logGeneral('Working in: ' . getcwd());
                              $write_to_file = $this->MyBase->writeFile($external_storage_path, $session_token . '.json', json_encode($prepared_score, JSON_NUMERIC_CHECK), null);
                              $this->MyBase->logGeneral('Writing to ' . $write_to_file);
                            }
                          }
                        }
                      }

                      $command_parameters = null;
                      if($command_test_parameters) {
                        $command_parameters = $command_test_parameters;
                      } else {
                        if($write_to_file) {
                          if(file_exists($write_to_file)) {
                            $command_parameters = $write_to_file;
                          }
                        }
                      }

                      // Run the external command as specified from the config
                      // We'll escape it first to be safe, then log it and put the
                      // results in a file as well as attach them to the response
                      // going back to the angular application
                      $command = escapeshellcmd($command_command . ' ' . $command_parameters);
                      $this->MyBase->logGeneral('Running [' . $command_command . '] with [' . $command_parameters . ']');
                      $start_timestamp = $this->MyBase->stringDateTime();
                      $output = shell_exec($command);
                      $this->MyBase->logGeneral('Got [' . $output . '] from ' . $command_name);

                      if(!$output) {
                        $output = 'No response from server';
                      }

                      $external_data_returned['results'] = $output;
                      $end_timestamp = $this->MyBase->stringDateTime();

                      // Write out the response from the external command to a file alongside of the
                      // responses data and the data sent to the external command
                      if((file_exists($external_storage_path)) && (isset($prepared_score))) {
                        $saved_output = array();
                        $saved_output['scores'] = $prepared_score;
                        $saved_output['output'] = trim($output);
                        $saved_output['created_at'] = $end_timestamp;
                        $saved_output['runtime'] = $start_timestamp;

                        $this->MyBase->logGeneral('Writing Cached data after sending to MDAT with MDAT response data');
                        $this->MyBase->logGeneral('Working in: ' . getcwd());
                        $write_to_file = $this->MyBase->writeFile($external_storage_path, $session_token . '_output.json', json_encode($saved_output, JSON_NUMERIC_CHECK), FILE_APPEND);
                        $this->MyBase->logGeneral('Writing to ' . $write_to_file);
                      }
                    }

                    $this->MyBase->respond(false, 'Update ' . ucfirst($model) . ' Succeeded', $external_data_returned);
                    $this->MyBase->sendResponse(false, false);
                  } else {
                    $this->MyBase->respond(true, 'Update ' . ucfirst($model) . ' Failed (Returned greater than 1)', null);
                    $this->MyBase->sendResponse(false, true);
                  }
                } else {
                  $this->MyBase->respond(true, 'Update ' . ucfirst($model) . ' Failed (No sessions match this token)', null);
                  $this->MyBase->sendResponse(false, true);
                }
              } catch(Exception $e) {
                  $this->MyBase->respond(true, 'Update ' . ucfirst($model) . ' Failed (0 unknown error)', null);
                  $this->MyBase->sendResponse(false, true);
              }
            }
          }
        } catch(Exception $e) {
          $this->MyBase->respond(true, 'Update ' . ucfirst($model) . ' Failed', null);
          $this->MyBase->sendResponse(false, true);
        }
      } else {
        $this->MyBase->respond(true, 'Update ' . ucfirst($model) . ' Denied', null);
        $this->MyBase->sendResponse(false, true);
      }
    }

    ###
    # This method is a private method, used to remove an array of characters
    # or strings from a specific string
    #
    private function commandStrips($strip, $data) {
      foreach($strip as $s) {
        $data = str_replace($s, '', $data);
      }
      return $data;
    }

    ##
    # This method is used for inserting data into the database
    #
    public function create($model, $params=null) {
      $this->getPostParams();

      $key = $this->getKey();
      $app_name = $this->getParam('app_name');

      $authorization_id = $this->setAuthorization($key, $app_name . '_session_token');
      $authentication_id = $this->setAuthentication($key, true, $authorization_id['id']);

      if($this->letsGo()) {
        try {
          $match = $this->MyBase->arraySearch($model, $this->authorized_tables, true);
          if($match) {
            $this->MyPDO->resetParams();
            if($model == 'sessions') {
              $sessions_id = $authentication_id;
              $this->MyPDO->addParamColumns(array('languages_id'));
              $clauses = array(
                $this->MyPDO->buildParamWhereClause('', 'id', 'sessions_id', '=')
              );
              $data = array('sessions_id' => $sessions_id, 'languages_id' => $this->getParam('languages_id'));
              $this->MyPDO->addParamWhereClauseGroup(array(
              	 'and_or' => '',
              	 'clauses' => $clauses
                )
              );
              $this->MyPDO->prepareQuery('update', 'sessions');
              if($sessions_id) {
                if($this->MyPDO->runQuery($data)) {
                  $this->MyBase->respond(false, 'Set ' . ucfirst($model) . ' Succeeded', $data);
                }
              } else {
                $this->MyBase->respond(true, 'Set ' . ucfirst($model) . ' Failed', null);
                $this->MyBase->sendResponse(false, true);
              }
            } else if($model == 'questions') {
            } else if($model == 'responses') {
            }
          }
        } catch(Exception $e) {
          $this->MyBase->respond(true, 'Set ' . ucfirst($model) . ' Failed', null);
          $this->MyBase->sendResponse(false, true);
        }
      } else {
        $this->MyBase->respond(true, 'Set ' . ucfirst($model) . ' Denied', null);
        $this->MyBase->sendResponse(false, true);
      }
    }
  }
?>
