<?php

	define('APPLICATION_PATH', dirname(__FILE__));

	#core Application class:
	include APPLICATION_PATH . "/include/lib/core/Application.php";

	#application instance:
	$app = Application::getInstance();

	#config:
	$config = $app->getConfig();

	#maintenance mode:
	if(!empty($config->maintenance_mode)) {
		$app->maintenanceMode();
	}

	#debug mode, include core, error handling and auto-include directories:
	$app->applyConfig($config);