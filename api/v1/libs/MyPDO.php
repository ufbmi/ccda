<?php
  class MyPDO {

    private $MyBase = null;
    private $config = null;

    public function __construct($MyBase=null) {

      try {
        if(!is_a($MyBase, 'MyBase')) {
          throw new Exception('No MyBase object passed to MyPDO');
        } else {
          $this->MyBase = $MyBase;
        }

        if(!$this->MyBase->__get('config')) {
          throw new Exception('No configuration passed to the loaded MyBase class object');
        } else {
          $this->config = $this->MyBase->__get('config');
          if(isset($this->config['database'])) {
            $this->config = $this->config['database'];

            $expected_configs = array('type', 'host', 'name', 'username', 'password', 'pdo_debug_mode', 'pdo_timeout', 'default_limit', 'timezone');
            foreach($expected_configs as $config_item) {
              if(isset($this->config[$config_item])) {
                $var_name = "db_" . $config_item;
                $this->$var_name = $this->config[$config_item];
              }
            }

            if($this->db_timezone) {
              date_default_timezone_set($this->db_timezone);
            } else {
              date_default_timezone_set('UTC');
            }

            $this->MyBase->logGeneral('Configured Successfully');
          } else {
            throw new Exception('Configuration of MyPDO failed (1)');
          }
        }
      } catch (Exception $e) {
        throw new Exception($e->getMessage());
      }


      // $this->connection = null;
      // $this->query = null;
      //
      // $this->resetParams();

      $this->error = array('pdo' => '', 'general' => '');

      $this->config['debug_modes'] = array(
        PDO::ERRMODE_SILENT,
        PDO::ERRMODE_WARNING,
        PDO::ERRMODE_EXCEPTION
      );

      $this->config['fetch_modes'] = array(
        PDO::FETCH_ASSOC,
        PDO::FETCH_BOTH,
        PDO::FETCH_BOUND,
        PDO::FETCH_CLASS,
        PDO::FETCH_INTO,
        PDO::FETCH_LAZY,
        PDO::FETCH_NUM,
        PDO::FETCH_OBJ
      );

      $this->config['fetch_styles'] = array(
        PDO::ATTR_DEFAULT_FETCH_MODE,
        PDO::FETCH_COLUMN,
        PDO::FETCH_UNIQUE,
        PDO::FETCH_GROUP,
        PDO::FETCH_ASSOC
      );
    }

    ###
    # This method returns the current error data in class variable this->error
    #
    public function getErrors() {
      if($this->error) {
        return $this->error;
      }
    }

    ###
    # This method resets the class variable containing query variables
    # to the default parameters required for queries to start at
    #
    public function resetParams() {
      $this->params = array(
        'columns' => array(),
        'offset' => 0,
        'limit' => $this->db_default_limit,
        'where_clauses' => array(),
        'group_by_clauses' => array(),
        'order_by_clauses' => array(),
        'query' => null
        );
    }

    public function handleException($type=null, $exception=null) {
      if(($type) && ($exception)) {
        $this->MyBase->logGeneral($exception->getMessage());

        throw new Exception($exception->getMessage());
        $this->error[$type] = $exception;
      }
    }

    public function addParamColumns($columns=array()) {
      foreach($columns as $column) {
        array_push($this->params['columns'], $column);
      }
    }

    public function buildOrderByClause($column, $direction=null) {
      if(!$direction) {
        $direction = 'ASC';
      }

      $new_clause = array(
        'column' => $column,
        'direction' => $direction
      );

      return $new_clause;
    }

    public function buildGroupByClause($column) {
      $new_clause = array(
        'column' => $column
      );
      return $new_clause;
    }

    public function buildParamWhereClause($and_or='', $column_name, $column_key=null, $condition) {

      if(!$column_key) {
        $column_key = $column_name;
      }

      $new_clause = array(
        'and_or' => $and_or,
        'column_name' => $column_name,
        'column_key' => $column_key,
        'condition' => $condition
      );

      return $new_clause;
    }

    public function addOffsetLimit($offset=null, $limit=null) {
      if(($offset >= 0) && ($limit >= 0)) {
        $this->params['offset'] = $offset;
        $this->params['limit'] = $limit;
      }
    }

    public function addParamWhereClauseGroup($clause_group=array()) {
      array_push($this->params['where_clauses'], $clause_group);
    }

    public function addParamGroupByClause($clauses=array()) {
      foreach($clauses as $clause) {
        array_push($this->params['group_by_clauses'], $clause);
      }
    }

    public function addParamOrderByClause($clause_group=array()) {
      $this->params['order_by_clauses'] = $clause_group;
    }

    public function init() {
      try {
        if($this->db_type == 'mysql') {
          $this->connection = new PDO("mysql:host=" . $this->db_host . ";dbname=" . $this->db_name . ';charset=UTF8',$this->db_username,$this->db_password);
          $this->MyBase->logGeneral('Connecting to: ' . $this->db_type . '/' . $this->db_host . '/' . $this->db_name);
        } else if($this->db_type == 'sqlite') {
          $this->connection = new PDO("sqlite:" . $this->db_name);
          $this->MyBase->logGeneral('Connecting to: ' . $this->db_type . '/' . $this->db_name);
        } else {
          throw new Exception('No connection type assigned for PDO: ' . $this->db_type . ', Supported: (mysql/mssql/sqlite)');
        }

        $this->connection->setAttribute(PDO::ATTR_ERRMODE,$this->config['debug_modes'][$this->db_pdo_debug_mode]);
        $this->connection->setAttribute(PDO::ATTR_TIMEOUT, $this->db_pdo_timeout);
        $this->MyBase->logGeneral('Successfully connected to ' . $this->db_type . ' database ' . $this->db_name);

        return true;
      } catch(PDOException $e) {
        $this->handleException('pdo', $e);
        return false;
      } catch(Exception $e) {
        $this->handleException('general', $e);
        return false;
      }
    }

    public function checkConnection() {
      if($this->connection) {
        return $this->connection;
      }
    }

    public function prepareQuery($type=null, $table=null, $fetch_mode=null, $manualQuery=null) {
      try {
        if(($table) && ($type)) {
          $this->MyBase->logGeneral('Preparing ' . $type . ' query on table: ' . $table);
          if($type == 'select') {
            $query = 'SELECT ';
            $columns = '';
            foreach($this->params['columns'] as $column) {
              if($columns) {
                $columns .= ',';
              }
              $columns .= $column;
            }
            $query .= $columns . ' FROM ' . $table;
            if(($this->params['where_clauses']) && (count($this->params['where_clauses']) > 0)) {
              $query .= $this->processWhereClause($this->params);
            }
            if(($this->params['group_by_clauses']) && (count($this->params['group_by_clauses']) > 0)) {
              $query .= $this->processGroupByClause($this->params);
            }
            if(($this->params['order_by_clauses']) && (count($this->params['order_by_clauses']) > 0)) {
              $query .= $this->processOrderByClause($this->params);
            }
            if((isset($this->params['offset'])) && (isset($this->params['limit']))) {
              $query .= $this->processLimitClause($this->params);
            }
          } else if($type == 'insert') {
            $query = 'INSERT INTO ' . $table . ' (';
            $columns = '';
            $values = '';
            foreach($this->params['columns'] as $column) {
              if($columns) {
                $columns .= ',';
              }
              $columns .= $column;

              if($values) {
                $values .= ',';
              }
              $values .= ':' . $column;
            }
            $query .= $columns . ') VALUES (' . $values . ')';
          } else if($type == 'update') {
            $query = 'UPDATE ' . $table . ' SET ';
            $columns = '';
            foreach($this->params['columns'] as $column) {
              if($columns) {
                $columns .= ',';
              }
              $columns .= $column . '=:' . $column;
            }
            $query .= $columns;
            $query .= $this->processWhereClause($this->params);
          } else if($type == 'delete') {
            $query = 'DELETE FROM ' . $table;
            $query .= $this->processWhereClause($this->params);
          } else {
            throw new Exception('Unsupported query type');
            return false;
          }

          $this->params['query'] = $query;

          $this->MyBase->logGeneral($query);

          $this->query = $this->connection->prepare($query);
          if($fetch_mode > -1) {
            $this->setFetchMode($fetch_mode);
          }

          return true;
        } else {

          if($manualQuery) {
            $this->MyBase->logGeneral('Preparing manual query');
            $this->MyBase->logGeneral($manualQuery);
            $this->query = $this->connection->prepare($manualQuery);
            if($fetch_mode > -1) {
              $this->setFetchMode($fetch_mode);
            }

            return true;
          } else {
            return false;
          }
        }
      } catch(PDOException $e) {
        $this->handleException('pdo', $e);
        return false;
      } catch(Exception $e) {
        $this->handleException('general', $e);
        return false;
      }
    }

    private function processOrderByClause($params=array()) {
      if(count($params['order_by_clauses']) > 0) {
        $query = ' ORDER BY ';
        //print_r($params['order_by_clauses']);
        for($x=0;$x<count($params['order_by_clauses']);$x++) {
          $clause = $params['order_by_clauses'][$x];
          // print_r($clause);
          if($x > 0) {
            $query .= ',';
          }
          $query .= $clause['column'] . ' ' . $clause['direction'];
        }
      }

      return $query;
    }

    private function processGroupByClause($params=array()) {
      if(count($params['group_by_clauses']) > 0) {
        $query = ' GROUP BY ';
        //print_r($params['group_by_clauses']);
        for($x=0;$x<count($params['group_by_clauses']);$x++) {
          $clause = $params['group_by_clauses'][$x];
          // print_r($clause);
          if($x > 0) {
            $query .= ',';
          }
          $query .= $clause['column'];
        }
      }

      return $query;
    }

    public function processWhereClause($params=array()) {
      $query = null;
      if(count($params['where_clauses']) > 0) {
        $query = ' WHERE';
        for($x=0;$x<count($params['where_clauses']);$x++) {
          $clause_group = $params['where_clauses'][$x];
          if($clause_group['and_or']) {
            if($x > 0) {
              $query .= ' ';
            }
            $query .= $clause_group['and_or'] . ' ';
          }
          $query .= ' (';
          for($y=0;$y<count($clause_group['clauses']);$y++) {
            $clause = $clause_group['clauses'][$y];
            if($clause['and_or']) {
              if($y > 0) {
                $query .= ' ';
              }
              $query .= $clause['and_or'] . ' ';
            }
            $query .= '(';
            $query .= $clause['column_name'];

            if($clause['condition'] == 'IS NULL') {
              $query .= ' IS NULL';
            } else {
              if($clause['condition'] == 'LIKE') {
                $query .= ' ' . $clause['condition'] . ' ';
              } else {
                $query .= $clause['condition'];
              }
              $query .= ':' . $clause['column_key'];
            }
            $query .= ')';
          }
          $query .= ')';
        }
      }

      return $query;
    }

    private function processLimitClause($params=array()) {
      if(($params['offset'] >= 0) && ($params['limit'] >= 0)) {
        return ' LIMIT ' . $params['offset'] . ', ' . $params['limit'];
      }
    }

    public function runQuery($data=null, $fetch_mode=null) {
      try {
        $this->query->execute($data);
        $this->MyBase->logGeneral(print_r($data, true));
        return true;
      } catch(PDOException $e) {
        $this->handleException('pdo', $e);
        return false;
      } catch(Exception $e) {
        $this->handleException('general', $e);
        return false;
      }
    }

    public function getLastId() {
      if($this->connection) {
        try {
          $id = $this->connection->lastInsertId();
          return $id;
        } catch(PDOException $e) {
          $this->handleException('pdo', $e);
          return false;
        } catch(Exception $e) {
          $this->handleException('general', $e);
          return false;
        }
      }
    }

    private function setFetchMode($fetch_mode) {
      try {
        if($this->query) {
          $this->query->setFetchMode($this->config['fetch_modes'][$fetch_mode]);
        } else {
          return false;
        }

        return true;
      } catch(PDOException $e) {
        $this->handleException('pdo', $e);
        return false;
      } catch(Exception $e) {
        $this->handleException('general', $e);
        return false;
      }
    }

    public function getAll($style=null, $argument=null, $ctor_args=null) {
      try {
        if($this->query) {

          if($style > -1) {
            $style = $this->config['fetch_styles'][$style];
          }

          if(($style) && ($argument) && ($ctor_args)) {
            $data = $this->query->fetchAll($style, $argument, $ctor_args);
          } else if(($style) && (!$argument)) {
            $data = $this->query->fetchAll($style);
          } else if(($style) && ($argument)) {
            $data = $this->query->fetchAll($style, $argument);
          } else {
            $data = $this->query->fetchAll();
          }

          return $data;
        } else {
          return false;
        }

        return true;
      } catch(PDOException $e) {
        $this->handleException('pdo', $e);
        return false;
      } catch(Exception $e) {
        $this->handleException('general', $e);
        return false;
      }
    }

    public function getQuery() {
      if($this->query) {
        return $this->query;
      } else {
        return false;
      }
    }

    public function close() {
      if($this->connection) {
        $this->connection = null;
        return true;
      } else {
        return false;
      }
    }
  }

?>
