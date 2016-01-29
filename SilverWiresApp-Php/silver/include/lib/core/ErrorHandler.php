<?php

	class ErrorHandler 
	{
		var $debugMode = false;

		function ErrorHandler($config = null)
		{
			if(is_null($config) && !is_object($config)) {
				return;
			}

			$this->debugMode = $config->debug_mode;
		}

		function register()
		{
			//ini_set('html_errors', 0);
			set_error_handler(array(&$this, 'onError'));
		}

		function onError($errno, $errmsg, $filename, $linenum, $vars)
		{
			if(!$this->debugMode) {
				return;
			}

			#erorile stricte le ignoram:
			$is_strict = defined('E_STRICT') && ($errno == E_STRICT);  // E_STRICT -> PHP5 specific
			if($is_strict) {
				return;
			}

			#afisam erorile:
			if(error_reporting() & $errno) {
				$output = $this->_getErrorOutput($errno, $errmsg, $filename, $linenum);
			}

			#daca e eroare fatala, kilarim scriptu:
			$is_fatal = in_array($errno, array(E_ERROR, E_USER_ERROR, E_PARSE, E_CORE_ERROR, E_COMPILE_ERROR));
			if($is_fatal) {
				Application::fatalError($output);
			}

			echo $output;

			//return false;
		}

		function _getErrorOutput($errno, $errmsg, $filename, $linenum)
		{
			//$time = isset($_SERVER['REQUEST_TIME']) ? $_SERVER['REQUEST_TIME'] : time();

			global $app;
			$relative_filename = str_replace('\\', '/', $filename);
			$relative_filename = str_replace($app->getApplicationPath(), '', $relative_filename);

			$html = '<div style="padding:3px;border:5px solid red;margin:5px">' . 
					'<b>' . $errmsg . '</b><br>' . 
					'File: <b>' . $relative_filename . '</b><br>' . 
					'Line: <b>' . $linenum . '</b>' .
					'</div>';

			return $html;
		}
	}
