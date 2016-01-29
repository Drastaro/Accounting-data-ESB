<?php

	class Cookie
	{
		function get($cookie_name)
		{
			if(isset($_COOKIE[$cookie_name])) {
				return $_COOKIE[$cookie_name];
			}

			return null;
		}

		function set($name, $value = null, $expire = null, $path = null, $domain = null, $secure = null, $httponly = null)
		{
			$defaults = Cookie::defaults();

			$value = is_null($value) ? $defaults['value'] : $value;
			$expire = is_null($expire) ? $defaults['expire'] : $value;
			$path = is_null($path) ? $defaults['path'] : $value;
			$domain = is_null($domain) ? $defaults['domain'] : $value;
			$secure = is_null($secure) ? $defaults['secure'] : $value;
			$httponly = is_null($httponly) ? $defaults['httponly'] : $value;

			if(is_array($value)) {
				$cookies = Cookie::_buildCookiesArray($name, $value);
				foreach($cookies as $cookie_name => $cookie_value) {
					setcookie($cookie_name, $cookie_value, $expire, $path, $domain, $secure, $httponly);
					//echo $cookie_name , ' = ' , $cookie_value, '<br>';
					//echo $expire, ' ', $path, ' ',$domain, ' ',$secure, ' ',$httponly, '<br>';
				}
			} else {
				setcookie($name, $value, $expire, $path, $domain, $secure, $httponly);
			}
		}

		function remove($name, $path = null, $domain = null, $secure = null, $httponly = null)
		{
			$defaults = Cookie::defaults();

			$path = is_null($path) ? $defaults['path'] : $value;
			$domain = is_null($domain) ? $defaults['domain'] : $value;
			$secure = is_null($secure) ? $defaults['secure'] : $value;
			$httponly = is_null($httponly) ? $defaults['httponly'] : $value;

			// extragem toate cookisurile care incep cu numele specificat (pentru cazul cookisurilor 'array'):
			$cookies = Cookie::getRawCookies($name);

			$name_len = strlen($name); // temp var

			foreach($cookies as $cookie_name => $cookie_value) {
				if(!isset($cookie_name{$name_len}) || $cookie_name{$name_len} == '[') {
					// cand nu e setat caracterul la pozitia resp, inseamna ca este exact numele specificat ca param. (deci stergem)
					// cand e setat caracterul, trebuie sa fie '[' pentru a indica ca este un coookie 'array' (si atunci stergem)
					setcookie($cookie_name, 0, 1, $path, $domain, $secure, $httponly);
				}
			}
		}

		function defaults($params = null)
		{
			static $defaults = null;

			if($defaults === null) {
				global $app;
				$domain = $app->getGenericHostname();
				$domain = strpos($domain, '.') ? ('.' . $domain) : false; //!!!

				#defaulturile initiale (satisfacatoare): 
				$defaults = array();
				$defaults['value'] = '';
				$defaults['expire'] = time() + 2600000; // aprox. 30 de zile
				#$defaults['path'] = '/';
				$defaults['path'] = $app->getContextPath() . '/';
				$defaults['domain'] = $domain; 
				$defaults['secure'] = 0;
				$defaults['httponly'] = 0;
				
				
			}

			# daca este setat un param, setam parametrii specificati:
			if(is_array($params)) {
				foreach($params as $param_name => $param_value)  {
					if(isset($defaults[$param_name])) {
						$defaults[$param_name] = $param_value;
					}
				}
			}

			return $defaults;
		}

		/**
		 * Returneaza cookisurile ne-parsate/ne-inlocuite cu array, din headerele HTTP (headerul Cookie)
		 */
		function getRawCookies($prefix = null)
		{
			$ret = array();

			if(isset($_SERVER['HTTP_COOKIE'])) {
				$cookies = explode(';', $_SERVER['HTTP_COOKIE']);

				foreach($cookies as $cookie) {
					@list($cookie_name, $cookie_value) = explode('=', $cookie, 2);
					$cookie_name = trim($cookie_name);
					$cookie_value = trim($cookie_value);

					// setam cookisu doar daca numele cookisului incepe cu prefixul specificat:
					if(is_null($prefix) || strpos($cookie_name, $prefix) === 0) {
						$ret[$cookie_name] = $cookie_value;
					}
				}
			}

			return $ret;
		}

	    function _buildCookiesArray($cookie_name, $cookie_array)
	    {
	        $build_array = array($cookie_name => $cookie_array);
	        $parts = explode('&', http_build_query($build_array, null, '&'));

	        $ret = array();

	        foreach($parts as $part) {
	            @list($name, $value) = explode('=', $part);
	            $ret[urldecode($name)] = urldecode($value);
	        }

	        return $ret;
	    }
	}
