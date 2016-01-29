<?php

	class Application
	{
		var $isCommandLine;

		var $applicationPath;
		var $baseUrl;
		var $contextPath;
		var $requestUri;

		var $config;

		function getApplicationPath()
		{
			return $this->applicationPath;
		}

		function getContextPath()
		{
			return $this->contextPath;
		}

		function getBaseUrl()
		{
			return $this->baseUrl;
		}

		function getRequestUri()
		{
			return $this->requestUri;
		}

		function getCurrentUrl()
		{
			if(empty($_SERVER['SERVER_NAME'])) {
				return ''; //command line, probabil
			}

			$proto = (empty($_SERVER['HTTPS']) || strtolower($_SERVER['HTTPS']) != 'on') ? 'http' : 'https';
			$server_name = $_SERVER['SERVER_NAME'];
			$request_uri = $_SERVER['REQUEST_URI'];

			$url = $proto . '://' . $server_name . $request_uri;

			return $url;
		}

		/**
		 * 
		 * @return Application
		 */
		public static function &getInstance() // statica
		{
			if(!defined('APPLICATION_PATH')) {
				trigger_error('APPLICATION_PATH constant is not defined', E_USER_ERROR);
			}

			static $app = null;

			if(is_null($app)) {
				#creeate new instance:
				$app = new Application;

				#test command line:
				$app->isCommandLine = (defined('STDIN') || empty($_SERVER['SERVER_NAME']));

				#application path:
				$app->applicationPath = $app->_normalizePath(APPLICATION_PATH);

				#library path:
				if(!defined('LIB_PATH')) {
					define('LIB_PATH', $app->applicationPath . '/include/lib');
				}

				#context path:
				if(empty($app->isCommandLine)) {
					$doc_root = $app->_normalizePath($_SERVER['DOCUMENT_ROOT']);
					$app->contextPath = str_replace($doc_root, '', $app->applicationPath);
				} else {
					$app->contextPath = '/';
				}

				#request uri:
				if(empty($app->isCommandLine)) {
					$request_uri = isset($_SERVER['PATH_INFO']) ? $_SERVER['PATH_INFO'] : $_SERVER['REQUEST_URI'];
					if($app->contextPath) {
						$pos = strpos($request_uri, $app->contextPath);
						if($pos === 0) {
							$request_uri = substr($request_uri, strlen($app->contextPath));
						}
					}
					$app->requestUri = $request_uri;
				}

				#base url:
				if(empty($app->isCommandLine)) {
					$app->baseUrl = 'http://' . $_SERVER['SERVER_NAME'] . $app->contextPath;
				} else if(isset($_SERVER['argv'][1])){
					$app->baseUrl = 'http://' . $_SERVER['argv'][1] . $app->contextPath;
				}

				#init config:
				$app->config = Application::getConfig();

				#init the predefined config vars:
				$app->config->is_command_line = $app->isCommandLine;

				if(empty($app->config->absolute_path)) {
					$app->config->absolute_path = APPLICATION_PATH;
				}

				if(empty($app->config->absolute_url)) {
					$app->config->absolute_url = $app->baseUrl; // . '/';
				}
				
				#register autoload:
				spl_autoload_register('Application::loadClass');
			}

			#return reference:
			$ref =& $app;
			return $ref;
		}

		/**
		 * 
		 * @return Config
		 */
		public static function &getConfig() //statica
		{
			static $config = null;

			if(is_null($config)) {
				$app = Application::getInstance();
				$root = $app->applicationPath;

				include $root . '/include/lib/core/Config.php';

				$config = new Config;

				#general config:
				include $root . "/config/general.php";

				#host specific config:
				if($app->isCommandLine) {	#cronurile de ex, ruleaza in command line mode
					require $root . '/config/cli.php';

					if(isset($_SERVER['argv'][1])) { // primu param. din command line ar trebui sa fie hostul pe care ruleaza...
						$file = $root . '/config/' . $_SERVER['argv'][1] . '/config.php';

						if(file_exists($file)) {
							require $file;
						} else {
							$app->fatalError('Invalid config file: ' . $file, true);
						}
					} else {
						$app->fatalError('Config folder to load is empty (argv[1])');
					}

					$config->debug_mode = true; //!!!
				} else {
					$file = $root . '/config/' . $app->getGenericHostname() . '/config.php';

					if(file_exists($file)) {
						require $file;
					} else {
						$app->fatalError('Cannot find config file');
					}
				}
			}

			$ref =& $config;
			return $ref;
		}

		/**
		 * 
		 * @param string $templates_dir
		 * @param string $templates_compile_dir
		 * @return Smarty
		 */
		public static function &getSmarty($templates_dir = null, $templates_compile_dir = null) //statica
		{
			static $smarty = null;

			if(is_null($smarty)) {

				$app = Application::getInstance();
				include_once $app->applicationPath . '/include/lib/smarty/Smarty.class.php';

				$smarty = new Smarty;

				if(is_null($templates_dir)) {
					$smarty->template_dir = APPLICATION_PATH . '/templates/';
				}

				if(is_null($templates_compile_dir)) {
					$smarty->compile_dir = APPLICATION_PATH . '/templates_c/';
				}

			}

			if(!is_null($templates_dir)) {
				$smarty->template_dir = APPLICATION_PATH . '/' . $templates_dir;
			}

			if(!is_null($templates_compile_dir)) {
				$smarty->compile_dir = APPLICATION_PATH . '/' . $templates_compile_dir;
			}

			#init smarty tags:
			#include_once LIB_PATH . '/tags/SmartyTag.php';

			#return a smarty reference:
			$ref =& $smarty;
			return $ref;
		}

		function &getErrorHandler()
		{
			static $errorHandler = null;

			if(is_null($errorHandler)) {
				$app = Application::getInstance();
				$root = $app->applicationPath;

				include_once $root . '/include/lib/core/ErrorHandler.php';

				$errorHandler = new ErrorHandler($app->config);
			}

			$ref =& $errorHandler;
			return $ref;
		}

		function applyConfig($config) //statica:
		{
			#debug mode:
			if(empty($config->debug_mode)) {
				$config->debug_mode = false;

				error_reporting(0);
				ini_set('display_errors', '0');
			} else {
				if(defined('E_STRICT') && !empty($config->default_timezone)) {
					ini_set('date.timezone', $config->default_timezone);
				}

				error_reporting(E_ALL);

				ini_set('display_errors', '1');
				ini_set('display_startup_errors','1');
			}

			#include core:
			require APPLICATION_PATH . '/include/lib/prepend.php';

			#error handling:
			$handler = $this->getErrorHandler();
			$handler->register();
			
			#ip filter
			if (isset($config->allowedIp) && isset($_SERVER['REMOTE_ADDR']) && !empty($config->allowedIp)){
				$pass = false;
				if (is_array($config->allowedIp)){
					if (in_array($_SERVER['REMOTE_ADDR'], $config->allowedIp)){
						$pass = true;
					}
				} else {
					if ($config->allowedIp == $_SERVER['REMOTE_ADDR']){
						$pass = true;
					}
				}
				
				if (!$pass){
					die($_SERVER['HTTP_HOST']);
				}
				
			}
			
		}

		function maintenanceMode()
		{
			if ($_SERVER['REQUEST_URI'] != '/maintenance.html') {
				header('HTTP/1.1 307 Temporary Redirect');
				header('Location: /maintenance.html');
				exit;
			}
			
			$app = Application::getInstance();
			$config = $app->getConfig();

			$template = $config->absolute_path . '/templates/components/maintenance.html';
			$content = file_get_contents($template);
			
			die($content);
		}

		function fatalError($msg)
		{
			header("HTTP/1.1 500 Internal Server Error");
			header("Status: 500 Internal Server Error");
			
			$app = Application::getInstance();
			
			if(headers_sent() || $app->isCommandLine) {
				die($msg);
			}

			$config = $app->getConfig();
			
			$template = APPLICATION_PATH . '/templates/components/error_fatal.html';
			$content = file_get_contents($template);

			#replace vars:
			$vars = '{$MESSAGE}';
			$values = $msg;
			$content = str_replace($vars, $values, $content);

			echo ($content);

			exit(1);
		}

		public static function loadClass($className) // statica
		{
			global $config;
			foreach ($config->auto_include_directories as $k => $v){
				$v = '/' . trim(trim($v, '/'),'\\') . '/';
				$fPath = $config->absolute_path . $v . $className . '.php';
				if (file_exists($fPath)){
					require_once $fPath;
				}
			}
		}

		function isCommandLine()
		{
			$app = Application::getInstance();
			return $app->isCommandLine;
		}

		function isPost()
		{
			//TODO: sa returneze din requestul curent(obiect)...
			return (strtolower($_SERVER['REQUEST_METHOD']) == 'POST');
		}

		function getGenericHostname()
		{
			if($this->isCommandLine) {
				return 'cli';
			}

			$hostname = $_SERVER['SERVER_NAME'];
			if(strpos($hostname, 'www.') === 0) {
				//daca incepe cu 'www.', il scoatem afara pt. ca este identic, de obicei
				$hostname = substr($hostname, 4);
			}

			//stergem si portul:
			$pos = strpos(':', $hostname);
			if($pos !== false) {
				$hostname = substr($hostname, 0, $pos);
			}

			return $hostname;
		}

		public static function getMappedPath($path)
		{
			$app = Application::getInstance();
			$context = $app->getContextPath();

			if($context && (strpos($path, '/') === 0)) {
				$path = $context . $path;
			}

			return $path;
		}

		function _normalizePath($path) // privata
		{
			return rtrim(str_replace('\\', '/', $path), '/');
		}
		
		public static function pageNotFound()
		{
			showPageNotFound();
		}
	}
