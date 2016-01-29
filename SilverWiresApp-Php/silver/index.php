<?php

//$mt = microtime(true);

error_reporting(E_ALL);
ini_set('display_errors', 1);

#init:
require_once "init.php";



#session
session_set_cookie_params(3600 * 24 * 7); // one week
ini_set("session.cookie_lifetime", 3600 * 24 * 7); // one week
if (isset($_COOKIE['sessid'])) {
	session_start($_COOKIE['sessid']);
	session_regenerate_id();
} else {
	session_start();
}
setcookie('sessid', session_id(), 3600 * 24 * 7); // one week


#url mapping:
require_once APPLICATION_PATH . "/include/lib/urls.php";


#smarty:
$smarty = Application::getSmarty('/templates/', '/templates_c/');


#authentication:
if(Users::isLogged()) {
	$user=Users::getLogged();
	$smarty->assign('user', $user);
	
	
	#get the page:
	if (empty($_GET['page'])) {
		$page = 'home';
	} else {
		$page = $_GET['page'];
	}
		

	
} else {
	if (!empty($_GET['page'])) {
		if (in_array($_GET['page'], array('pass'))) {
			$page = $_GET['page'];
		} else {
			jump(Application::getMappedPath('/'));
		}
	} else {
		$page = 'login';
	}
}

if (Messages::areErrors()) {
	$smarty->assign('messageClass', 'callout-danger');
} else {
	$smarty->assign('messageClass', 'callout-success');
}
$smarty->assign('areMessages', Messages::areMessages());
$smarty->assign('pageMessages', Messages::getMessages());

#controller
$controller = APPLICATION_PATH . '/pages/' . $page . '.php';
$template = $page . '.tpl';

if(file_exists($controller))
{
	require_once $controller;

	if($smarty->getTemplateVars('CONTENT')) {
		$template = $smarty->getTemplateVars('CONTENT');
	}
}

if(!file_exists(APPLICATION_PATH . '/templates/' . $template)) {
	showPageNotFound();
}

#assign smarty vars
assignCommonVars();
$smarty->assign('CONTENT', $template);


#output:
$smarty->display('components/index.tpl');

//echo 'EXEC-TIME: ' . (microtime(true) - $mt);
