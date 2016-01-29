<?php

	class DbSqlManager
	{

		public $host;
		public $database;
		public $user;
		public $password;

		public $debug = false;

		private $record = array();
		private $row;

		private static $linkId  = array();
		private $queryId = null;
		private $className;

		function __construct($query = null)
		{
			$this->className = get_class($this);
			
			if ($this->className == 'DbSqlManager'){
				trigger_error('This class should be extended', E_USER_WARNING);
			}
			
			$this->connect();
			$this->query($query);
		}

		public function connect()
		{			
			if (!isset(self::$linkId[$this->database . $this->className])) {
				//self::$linkId[$this->database . $this->className] = mysql_connect($this->host, $this->user, $this->password, true);
				self::$linkId[$this->database . $this->className] = mysqli_connect($this->host, $this->user, $this->password, $this->database);
				if (!isset(self::$linkId[$this->database . $this->className])) {
					$this->fatalError('connect(' . $this->host . ', ' . $this->user . ', $Password) failed.');
				}

				/*if (!mysql_select_db($this->database, self::$linkId[$this->database . $this->className])) {
					$this->fatalError('cannot use database ' . $this->database);
				}*/
				//mysql_set_charset('utf8', self::$linkId[$this->database . $this->className]);
			}
		}
		
		public function query($queryString = '')
		{
			
			if(empty($queryString)) {
				return;
			}

			if ($this->queryId) {
				$this->free();
			}

			//$this->queryId = mysql_query($queryString, self::$linkId[$this->database . $this->className]);
			$this->queryId = mysqli_query(self::$linkId[$this->database . $this->className], $queryString);
			$this->row   = 0;

			if (!$this->queryId) {
				$this->fatalError('Invalid SQL: ' . $queryString);
			}
		}
		
		public function getAllRecords()
		{
			$ret = array();
			while ($this->nextRecord()){
				$ret[] = $this->getRecord();
			}
			return $ret;
		}
		
		public function realEscape($string = '')
		{
			return mysqli_real_escape_string(self::$linkId[$this->database.$this->className], $string);
		}
		
		public function nextRecord() 
		{
			//$this->record = mysql_fetch_assoc($this->queryId);
			$this->record = $this->queryId->fetch_assoc();
			$this->row   += 1;
			
			return is_array($this->record);
		}
		
		public function getRecord()
		{
			return $this->record;
		}
		
		public function insertId()
		{
			return mysqli_insert_id(self::$linkId[$this->database.$this->className]);
		}
		
		public function free()
		{
			if(is_resource($this->queryId)) {
				mysqli_free_result($this->queryId);
			}
			$this->queryId = null;
		}
		
		public function affectedRows()
		{
			return mysqli_affected_rows(self::$linkId[$this->database.$this->className]);
		}

		public function numRows()
		{
			return mysqli_num_rows($this->queryId);
		}

		public function numFields() 
		{
			return mysqli_field_count($this->queryId);
		}

		public function nf() 
		{
			return $this->numRows();
		}

		public function f($name) 
		{
			return $this->record[$name];
		}
		
		public function lock($table, $mode = 'write')
		{
			$this->connect();

			$query = "lock tables ";

			if (is_array($table)) {
				while (list($key, $value) = each($table)) {
					if ($key == 'read' && $key != 0) {
						$query .= $value . ' read, ';
					} else {
						$query .= $value . ' ' . $mode . ', ';
					}
				}

				$query = substr($query, 0, -2);
			} else {
				$query .= $table . ' ' . $mode;
			}

			$res = mysqli_query(self::$linkId[$this->database.$this->className], $query);

			if (!$res) {
				$this->error('lock(' . $table . ', ' . $mode . ') failed.');
			}
		}

		public function unlock()
		{
			$this->connect();

			$res = mysqli_query(self::$linkId[$this->database.$this->className], "unlock tables");

			if (!$res) {
				$this->error('unlock() failed.');
			}
		}
		
		private function error($msg)
		{
			$error = mysqli_error(self::$linkId[$this->database.$this->className]);
			$errno = mysqli_errno(self::$linkId[$this->database.$this->className]);

			if($this->debug) {
				printf("<b>Database error:</b> %s<br>\n", $msg);
				printf("<b>MySQL Error</b>: %s (%s)<br>\n",  $errno, $error);
			}
		}
		
		private function fatalError($msg) 
		{
			$error = mysqli_error(self::$linkId[$this->database.$this->className]);
			$errno = mysqli_errno(self::$linkId[$this->database.$this->className]);

			if($this->debug) {
				printf("<b>Database error:</b> %s<br>\n", $msg);
				printf("<b>MySQL Error</b>: %s (%s)<br>\n",  $errno, $error);
				die;
			}
			
			Application::fatalError("An Internal Server Error Ocurred. Please report this to the webmaster.");
		}
		
		public function __clone()
		{
			trigger_error('Clone is not allowed.', E_USER_ERROR);
		}
		
	}
		