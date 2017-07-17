<?php
	include_once( './config.php' );

	include_once( $config['lib_path'] . 'MyBase.php' );
	include_once( $config['lib_path'] . 'MyRoute.php' );
	include_once( $config['lib_path'] . 'MyPDO.php' );
	include_once( $config['lib_path'] . 'MyAPI.php' );

	$MyBase = new MyBase($config, './logs/base_fail.log');

	$MyPDO = new MyPDO($MyBase);
	$MyRoute = new MyRoute($MyBase);
	$MyAPI = new MyAPI($MyBase, $MyPDO);

  $MyRoute->addRoute('POST', '/init', array($MyAPI, 'init'));
  $MyRoute->addRoute('POST', '/check', array($MyAPI, 'check'));
  $MyRoute->addRoute('POST', '/authorize', array($MyAPI, 'authorize'));

  $MyRoute->addRoute('GET', '/get/:model/', array($MyAPI, 'get'));
  $MyRoute->addRoute('GET', '/get/:model/:params', array($MyAPI, 'get'));

  $MyRoute->addRoute('POST', '/create/:model/', array($MyAPI, 'create'));
  $MyRoute->addRoute('POST', '/create/:model/:params', array($MyAPI, 'create'));

  $MyRoute->addRoute('POST', '/update/:model/', array($MyAPI, 'update'));
  $MyRoute->addRoute('POST', '/update/:model/:params', array($MyAPI, 'update'));

  # todo return a boolean
  $MyRoute->doRouting();

  if(!$MyRoute->__get('routed')) {
    #print($MyRoute->noRoute());
    # sends the response: No Route for...
    $MyRoute->noRoute();
  }
?>
