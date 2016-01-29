<?php
	
	function urlParse($string) {
		$getParams = parse_url(trim($string, '/ '));
		
		$params = array();
		if (!empty($getParams['path'])) {
			$params = explode('/', $getParams['path']);
		}
		
		if (!empty($getParams['query'])){
			$queryParams = explode('&', $getParams['query']);
		}

		$ok = 1;
		foreach($params as $parameter) {
			$parts = explode('.', $parameter, 2);
			if(empty($parts[0])) {
				continue;
			}
			if ($ok === 1) {
				$_GET['page'] = safeFileName(urldecode($parameter));
				$ok = 2;
				continue;
			}
			
			$param_name  = $parts[0];
			$param_value = isset($parts[1]) ? $parts[1] : '';
			
			if (in_array($param_value, array('jpg'))) {
				$_GET[] = $param_name;
				continue;
			}
			
			if (empty($param_value)) {
				$_GET[] = urldecode($param_name);
			} else {
				$_GET[$param_name] = urldecode($param_value);
			}
		}
	}
	
	urlParse($app->getRequestUri());