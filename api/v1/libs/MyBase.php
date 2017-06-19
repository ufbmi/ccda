<?php
  class MyBase {

    // Stores a local copy of the config array passed to the class
    private $config = null;

    // Config based class variables
    private $debug = null;
    private $log_path = null;
    private $log_name = null;
    private $log_advanced = false;
    private $log_full_path = null;
    private $output_format = null;
    private $timezone = null;

    // Class variables used for switching & controls
    private $response = null;
    private $fail_gracefully = false;

    # Method: Constructor($config=null, $log_path)
    # Purpose: Initialize the class
    # $config [Type: array() Default: null]
    # $log_path
    public function __construct($config=null, $fail_gracefully_to=null) {

      $this->__set('fail_gracefully', $fail_gracefully_to);

      try {
        if(!$config) {
          throw new Exception('No configuration passed to MyBase Library');
        } else {
          $this->__set('config', $config);
          $this->__set('debug', $this->getConfigVariable('debug'));

          $log_path = $this->getConfigVariable('log_path');
          if($log_path) {
            $this->__set('log_path', $log_path);
            if(!file_exists($this->__get('log_path'))) {
              if($this->__get('log_path')) {
                mkdir($this->__get('log_path'), true);
              } else {
                $this->failureMessage('Could not create log directory', 'log_path');
              }
            }

            if(file_exists($this->__get('log_path'))) {
              $log_name = $this->getConfigVariable('log_name');
              if($log_name) {
                $this->__set('log_name', $log_name);
                $this->__set('log_full_path', $this->__get('log_path') . $this->__get('log_name'));
                if(!file_exists($this->__get('log_full_path'))) {
                  touch($this->__get('log_full_path'));
                }
              }
            }
          } else {
            $this->failureMessage('No log path was specified', 'log_path');
          }

          $this->__set('log_advanced', $this->getConfigVariable('log_advanced'));
          $this->__set('output_format', $this->getConfigVariable('output_format'));
          $timezone = $this->getConfigVariable('timezone');
          if($timezone) {
            date_default_timezone_set($timezone);
          } else {
            date_default_timezone_set('UTC');
          }
        }
      } catch(Exception $e) {
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
    # This method is used to retrieve a variable from a configuration
    # array, either at the root, or up to 2 levels diskfreespace
    #
    public function getConfigVariable($name=null, $sub_name_a=null, $sub_name_b=null) {
      if(($name) && (!$sub_name_a) && (!$sub_name_b)) {
        if(isset($this->config[$name])) {
          return $this->config[$name];
        } else {
          return null;
        }
      } else if(($name) && ($sub_name_a) && (!$sub_name_b)) {
        if(isset($this->config[$name][$sub_name_a])) {
          return $this->config[$name][$sub_name_a];
        } else {
          return null;
        }
      } else if(($name) && ($sub_name_a) && ($sub_name_b)) {
        if(isset($this->config[$name][$sub_name_a][$sub_name_b])) {
          return $this->config[$name][$sub_name_a][$sub_name_b];
        } else {
          return null;
        }
      } else {
        return null;
      }
    }

    ###
    # This method is used to retrieve a variable from a configuration
    # array, either at the root, or up to 2 levels diskfreespace
    #
    public function setConfigVariable($value=null, $name=null, $sub_name_a=null, $sub_name_b=null) {
      if(($name) && (!$sub_name_a) && (!$sub_name_b)) {
        if($name == 'config') {
          $this->__set('config', $value);
          return true;
        } else {
          if(isset($this->config[$name])) {
            $this->config[$name] = $value;
            return true;
          } else {
            return null;
          }
        }
      } else if(($name) && ($sub_name_a) && (!$sub_name_b)) {
        if(isset($this->config[$name][$sub_name_a])) {
          $this->config[$name][$sub_name_a] = $value;
          return true;
        } else {
          return null;
        }
      } else if(($name) && ($sub_name_a) && ($sub_name_b)) {
        if(isset($this->config[$name][$sub_name_a][$sub_name_b])) {
          $this->config[$name][$sub_name_a][$sub_name_b] = $value;
          return true;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }

    ###
    # This method is a substitute method for the normal PHP array_search, as
    # the normal php array search can give false negatives based on this article
    # http://php.net/array_search (read the WARNING)
    #
    public function arraySearch($needle, $haystack, $strict=false) {
      $key = array_search($needle, $haystack, $strict);
      if(is_integer($key)) {
        return true;
      } else {
        return false;
      }
    }

    ###
    # This method generates an md5 sum from a string. Given and array ($implode)
    # It breaks down this array by $glue.  It can also be passed a min,max
    # to generate randomness in the string
    #
    public function generateKey($min=null,$max=null, $implode=null, $glue=null) {
      $string_to_md = '';
      if(($implode) && count($implode) > 0) {
        $string_to_md = implode($glue, $implode);
      } else {
        if(($min) && ($max)) {
          $string_to_md = mt_rand($min, $max);
        } else {
          $string_to_md = mt_rand();
        }
      }

      return md5($string_to_md);
    }

    ###
    # Returns a DateTime object based on a string containing a date
    #
    public function getDateTime($date=null, $timezone=null) {
      # If there is nothing in $data, substitute with the keyword NOW
      if(!$date) {
        $date = 'now';
      }

      # If there is no timezone specified, use GMT
      if(!$timezone) {
        $timezone = 'GMT';
      }

      # Return the DateTime object, formatted with $data and $timezone
      $data = new DateTime($date, new DateTimeZone($timezone));
      return $data;
    }

    ###
    # This method simply returns a DateTime object, formatted as string
    # specified by the $format variable. It utilizes the public method
    # in this class called getDateTime
    #
    public function stringDateTime($date=null, $timezone=null, $format=null) {
      if(!$format) {
        $format = 'Y-m-d H:i:s';
      }

      $date = $this->getDateTime($date, $timezone);
      return $date->format($format);
    }

    ###
    # This method gets a DateTime object based on a future time period, specified
    # by passing in a $period and $units (example: 10 days)
    #
    public function getDateTimeFromNow($period, $units, $timezone=null, $format=null, $from=null) {
      if(!$timezone) {
        $timezone = 'GMT';
      }

      if(!$format) {
        $format = 'Y-m-d H:i:s';
      }

      if(($period) && ($units)) {
        $date = $this->getDateTime($from, $timezone);
        date_sub($date, date_interval_create_from_date_string($period . ' ' . $units));
        $expiration = date_format($date, $format);
      } else {
        $expiration = null;
      }

      return $expiration;
    }

    ###
    # This method simply returns an IP address based on the client address
    # reported to apache
    #
    public function getIpAddress() {
      if(isset($_SERVER['REMOTE_ADDR'])) {
        return $_SERVER['REMOTE_ADDR'];
      } else {
        return '127.0.0.1';
      }
    }

    ###
    # This method simply creates a JSON object for passing back to the
    # application which requested data from the API
    #
    public function makeJSONOutput($error=true, $message=null, $results=null) {
      $output = array('error' => true, 'message' => '', 'count' => 0, 'results' => array());
      $output['error'] = $error;

      if($message) {
        $output['message'] = $message;
      }

      if($results) {
        $output['results'] = $results;
        $output['count'] = count($results);
        $output['version'] = $this->getConfigVariable('app_version');
      }

      return json_encode($output);
    }

    private function checkFile($path) {
      $file_mtime = @filemtime($path);
      $file_exists = !!$file_mtime;
      return $file_exists;
    }

    ###
    # This method writes a log entry based on configuration passed to this
    # class
    #
    public function log($object, $method, $data, $level, $path) {
      if($this->getConfigVariable('log_date_format')) {
        $format = $this->getConfigVariable('log_date_format');
      } else {
        $format = 'Y-m-d H:i:s';
      }

      if($this->getConfigVariable('app_name')) {
        $this_app = $this->getConfigVariable('app_name');
      } else {
        $this_app = 'default';
      }

      $delimiter = "\t";
      $object = str_pad($object, 15, '.');
      $method = str_pad($method, 30, '.');
      $this_date = $this->stringDateTime(null, null, $format);
      $this_ip = $this->getIpAddress();

      $line = '[' . $this_date . ']' . $delimiter . '[' . $this_ip . ']' . $delimiter
        . '[' . $this_app . ']' . $delimiter . '[' . $object . ']' . $delimiter . '[' . $method . ']' . $delimiter . '"'
        . $data . '"' . $delimiter . PHP_EOL;

      if($this->__get('debug')) {
        $file_exists = file_exists($path);
        if(!$file_exists) {
          touch($path);
        } else {
          error_log($line, $level, $path);
        }
      } else {
        // TODO: Need to make a way to log other than filesystem, maybe
        // a custom error_handler in the future
      }
    }

    ###
    # This method writes a file to a location, using the file_put_contents
    # method provided in PHP, which is a short for fopen, fwrite, fclose
    #
    public function writeFile($path, $file, $data, $flags=null) {

      if(($file) && ($path)) {
        # Put together the path and the filename for convenience
        $full_path = $path . $file;

        # Check for existence of the file path, and create directories
        # recursively along the way if needed
        if(!file_exists($path)) {
          mkdir($path, 0755, true);
        }

        # First check to see if anything is being added to the file
        if($data) {
          # Check to see if any custom flags were sent
          if($flags) {
            file_put_contents($full_path, $data, $flags);
          } else {
            file_put_contents($full_path, $data);
          }
        }

        # Re-check the files existence and send back NULL if it was not
        # created
        if(file_exists($full_path)) {
          return $full_path;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }

    ###
    # This method validates a JSON object
    #
    public function jsonValidate($string) {
        // decode the JSON data
        $result = json_decode($string);

        // switch and check possible JSON errors
        switch (json_last_error()) {
            case JSON_ERROR_NONE:
                $error = null; // JSON is valid // No error has occurred
                break;
            case JSON_ERROR_DEPTH:
                $error = 'The maximum stack depth has been exceeded.';
                break;
            case JSON_ERROR_STATE_MISMATCH:
                $error = 'Invalid or malformed JSON.';
                break;
            case JSON_ERROR_CTRL_CHAR:
                $error = 'Control character error, possibly incorrectly encoded.';
                break;
            case JSON_ERROR_SYNTAX:
                $error = 'Syntax error, malformed JSON.';
                break;
            // PHP >= 5.3.3
            case JSON_ERROR_UTF8:
                $error = 'Malformed UTF-8 characters, possibly incorrectly encoded.';
                break;
            // PHP >= 5.5.0
            case JSON_ERROR_RECURSION:
                $error = 'One or more recursive references in the value to be encoded.';
                break;
            // PHP >= 5.5.0
            case JSON_ERROR_INF_OR_NAN:
                $error = 'One or more NAN or INF values in the value to be encoded.';
                break;
            case JSON_ERROR_UNSUPPORTED_TYPE:
                $error = 'A value of a type that cannot be encoded was given.';
                break;
            default:
                $error = 'Unknown JSON error occured.';
                break;
        }

        return $error;
    }

    public function respond($error, $message, $results=array()) {
      if(!isset($message)) {
        $error = true;
        $message = 'No message or results method';
      }

      if($this->__get('log_advanced')) {
        $backtrace = debug_backtrace();
      }

      if((isset($backtrace)) && (isset($backtrace[1]['class']))) {
        $object = $backtrace[1]['class'];
      } else {
        $object = 'UnknownClass';
      }

      if((isset($backtrace)) && (isset($backtrace[1]['function']))) {
        $method = $backtrace[1]['function'];
      } else {
        $method = 'UnknownMethod';
      }

      $this->logGeneral('Response: ' . $message, null, $object, $method);
      $this->response = $this->makeOutput($error, $message, $results);
    }

    public function getResponse() {
      return $this->response;
    }

    public function sendResponse($cancel=false, $terminate=false, $print=true) {
      if(!$cancel) {
        try {
          if($print) {
            print_r($this->response);
          }
          if($terminate) {
            die();
          } else {
            return true;
          }
        } catch(Exception $e) {
          return false;
        }
      }
    }

    ##
    # Universal method for sending output back to the user, so that output
    # is centrally controlled/formatted
    #
    public function makeOutput($error=true, $message=null, $results=null) {
      if($this->__get('output_format') == 'json') {
        return $this->makeJSONOutput($error, $message, $results);
      } else if($this->getOutputFormat()) {
        return $this->makeCSVOutput($error, $message, $results);
      } else {
        $this->logGeneral('No output format configured');
        $this->failureMessage('No output format configured', 'output_format');
      }
    }

    # Method: failureMessage($message, $config_a=null, $config_b=null, $config_c=null)
    # Purpose: To show terminal failures that cause the application to function improperly
    public function failureMessage($message, $config_a=null, $config_b=null, $config_c=null) {
      if($config_a) {
        $config_string = "config['" . $config_a . "']";
        if($config_b) {
          $config_string .= "['" . $config_b . "']";
          if($config_c) {
            $config_string .= "['" . $config_c . "']";
          }
        }
      }

      $log = $message . '. Check your config file for ' . $config_string . '. Current setting: ' . $this->getConfigVariable($config_a, $config_b, $config_c);
      $log .= "<p>Stacktrace:</p>\n";

      $backtrace = debug_backtrace();
      $log .= "<pre>\n";
      $log .= print_r($backtrace[0], true);
      $log .= print_r($backtrace[1], true);
      $log .= "</pre>\n";

      if($this->__get('fail_gracefully')) {
        file_put_contents($this->__get('fail_gracefully'), $log);
      } else {
        print($log);
      }

      die();
    }

    ##
    # This logging method, is specific to logging general log entries
    #
    public function logGeneral($message, $data=null, $foreign_object=null, $foreign_method=null) {
      // Check the existing log and roll it over if it is too
      // large to fit into the configured file size
      if(file_exists($this->__get('log_full_path'))) {
        $log_size = filesize($this->__get('log_full_path'));
        $configured_log_size = $this->getConfigVariable('log_size');
        if($log_size >= $configured_log_size) {
          $new_name = $this->stringDateTime(null, null, 'YmdHis') . '.log';
          rename($this->__get('log_full_path'), $this->__get('log_path') . $new_name);
          touch($this->__get('log_full_path'));

          if(file_exists($this->__get('log_full_path'))) {
            $this->logGeneral('Rolling over log file ' . $log_size . ' exceeds configured ' . $configured_log_size);
          } else {
            $this->failureMessage('Log file did not roll over. Is it possible that it was not able to be created?', '');
          }
        }

        if($this->__get('log_advanced')) {
          $backtrace = debug_backtrace();
        }

        if($foreign_object) {
          $object = $foreign_object;
        } else {
          if((isset($backtrace)) && (isset($backtrace[1]['class']))) {
            $object = $backtrace[1]['class'];
          } else {
            $object = 'UnknownClass';
          }
        }

        if($foreign_method) {
          $method = $foreign_method;
        } else {
          if((isset($backtrace)) && (isset($backtrace[1]['function']))) {
            $method = $backtrace[1]['function'];
          } else {
            $method = 'UnknownMethod';
          }
        }

        $this->log($object, $method, $message, 3, $this->__get('log_full_path'));
        if($data) {
          $this->log($object, $method, print_r($data, true), 3, $this->__get('log_full_path'));
        }
      }
    }
  }
?>
