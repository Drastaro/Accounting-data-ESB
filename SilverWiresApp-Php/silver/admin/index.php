<?php

	#init:
	include dirname(dirname(__FILE__)) . DIRECTORY_SEPARATOR . 'init.php';
	$config->page_meta->title = $config->project_name;
	
	#smarty:
	$smarty = Application::getSmarty('/admin/templates/', '/admin/templates_c/');
	
	include_once APPLICATION_PATH . "/config/messages_ro.php";
	
	$page = empty($_GET['page']) ? 'home' : $_GET['page'];
	$action = empty($_GET['action']) ? 'index' : $_GET['action'];
	
	
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
	$smarty->assign('SESSION_ID', session_id());
	
	
	#authentication:
	if(Admin::isLogged()) {
		$adminUser = Admin::getLogged();
		Admin::checkPageAccess($page);
		$smarty->assign('ADMIN', $adminUser);
	} else {
		$page = 'login';
	}

	$breadCrumb = new BreadCrumb;
	$breadCrumb->add('Admin', '/admin/');

	if(file_exists($config->absolute_path.'/admin/pages/' . $page . '.php')) {
		
		require_once $config->absolute_path.'/admin/pages/' . $page . '.php';
		
		$content_var = $smarty->getTemplateVars('CONTENT');
		if(empty($content_var)) {
			$content_var = $page . '.tpl';
		}
	
	} else if(file_exists($config->absolute_path.'/admin/pages/' . $page . '/' . $action . '.php')) {
		
		require_once $config->absolute_path.'/admin/pages/' . $page . '/' . $action . '.php';

		$content_var = $smarty->getTemplateVars('CONTENT');
		if(empty($content_var)) {
			$content_var = $page . '/' . $action . '.tpl';
		}
		
	} else if(file_exists($config->absolute_path.'/admin/templates/' . $page . '.tpl')) {
		$content_var = $page . '.tpl';
		
	} else if(file_exists($config->absolute_path.'/admin/templates/' . $page . '/' . $action . '.tpl')) {
		$content_var = $page . '/' . $action . '.tpl';
		
	} else {
		header("HTTP/1.1 404 Not Found");

		$smarty->assign('ERROR', '<h3>Această pagină nu există.</h3>'
								.'Dacă ați ajuns aici din geșeală contactați administratorul!');
		$smarty->assign('ERROR_TITLE', 'Hmmm...');

		$content_var = 'components/error.tpl';
	}
	$smarty->assign('CONTENT', $content_var);

	$smarty->assign('breadCrumbHtml', $breadCrumb->getHtml());

	$smarty->assign('config', $config);
	$smarty->assign('page', $page);
	if (Messages::areErrors()) {
		$smarty->assign('noticeBoxColor', 'noticeBoxRed');
	} else {
		$smarty->assign('noticeBoxColor', 'noticeBoxGreen');
	}
	$smarty->assign('noticeBoxMessages', Messages::getMessages());

    $config->page_meta->title = "[A] " . $config->page_meta->title;

	$smarty->display('components/index.tpl');
	