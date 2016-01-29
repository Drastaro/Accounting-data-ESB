<?php


	class DbMySql extends DbSqlManager 
	{

		function __construct($query = null, $db = 'default')
		{
			$conf = $GLOBALS['config']->mysql[$db];

			$this->host = $conf->host;
			$this->database = $conf->database;
			$this->user = $conf->user;
			$this->password = $conf->password;
			$this->debug = $GLOBALS['config']->debug_mode;
			
			parent::__construct($query);
		}

	}