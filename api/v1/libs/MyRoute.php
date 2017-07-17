<?php
  class MyRoute {

    private $MyBase = null;
    private $requested_url = null;
    private $routes = null;
    private $routed = null;
    private $base_url = null;

    public function __construct($MyBase=null) {

      try {
        if(!is_a($MyBase, 'MyBase')) {
          throw new Exception('No MyBase object passed to MyRoute');
        } else {
          $this->MyBase = $MyBase;
        }

        if(!is_array($this->MyBase->__get('config'))) {
          throw new Exception('No configuration passed to the loaded MyBase class object');
        } else {
          $this->requested_url = null;
          $this->routes = [];

          // Set the base url of the application, so the router knows what the request should contain
          $this->base_url = $this->MyBase->getConfigVariable('base_url');

          // Denotes that there has not been a route selected. This allows for a default message to show
          // if no route was found for the incoming request
          $this->isRouted = false;
        }
      } catch (Exception $e) {
        throw new Exception($e->getMessage());
      }
    }

    public function __set($property, $value) {
      if(property_exists($this, $property)) {
        $this->$property = $value;
      } else {
        return false;
      }
    }

    public function __get($property) {
      if (isset($this->$property)) {
        return $this->$property;
      } else {
        return false;
      }
    }

    ###
    # This method adds a new route to the router
    #
    public function addRoute($method, $url, $callback) {
      $this->routes[] = array('method' => $method,
        'url' => $url,
        'callback' => $callback
      );
    }

    ###
    # This method is run whenever there is a failure to route due to no route being
    # allowed for the requested url
    #
    public function noRoute($print=true) {

      $this->MyBase->respond(true, 'No Route for [' . $this->requested_url . ']', array());
      $this->MyBase->sendResponse(false, false, $print);
      return true;
    }

    ###
    # This method is called to begin routing based on the request
    # received
    #
    public function doRouting() {
      $this->__set('requested_url', str_replace($this->base_url,'',$_SERVER['REQUEST_URI']));
      $reqMet = $_SERVER['REQUEST_METHOD'];
      $run = -1;

      // $this->MyBase->respond(true, 'routes content', $this->routes);
      // $this->MyBase->sendResponse(false, false, true);
 
 	// print_r($this->routes);
 	// print_r($this->requested_url);
	# exit(1);

      foreach($this->routes as $route) {
        $route['url'] = rtrim($route['url'], '/');
        // convert urls like '/users/:uid/posts/:pid' to regular expression
        $pattern = preg_replace('/\\\:[a-zA-Z0-9\_\-\&\=\%]+/', '([a-zA-Z0-9\-\_\&\=\%]+)', preg_quote($route['url'], '@'));
        $pattern = "@^$pattern/?$@D";
        $matches = array();

        if ($reqMet == $route['method']
		&& preg_match($pattern, $this->requested_url, $matches)) {
          // remove the first match
          // print_r($matches);
          array_shift($matches);
          // call the callback with the matched positions as params
          $run++;

	  # set the flag indicating that a route was found
          $this->__set('routed', true);
          return call_user_func_array($route['callback'], $matches);
        }
      }
    }
  }
?>
