<?php

	$config->debug_mode = true;
	$config->maintenance_mode = false;

	$config->mysql['default'] = new stdClass;
	$config->mysql['default']->host = 'localhost';
	$config->mysql['default']->database = 'silverwireapp';
	$config->mysql['default']->user = 'root';
	$config->mysql['default']->password = 'mircea';
	
	$config->sw_admin_url = 'http://localhost:8080/SilverWiresAdmin';
	
	setlocale(LC_TIME, array('ro_RO.ISO8859-1', 'ro_RO.ISO-8859-1', 'ro', 'ro_RO', 'rom', 'romanian'));
