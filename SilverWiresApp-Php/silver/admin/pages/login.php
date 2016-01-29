<?php

	if (Admin::isLogged()) {
		jump('index.php?page=home');
	}

	if ($config->isPost()) {
		if(Admin::login($_POST['email'], $_POST['password'])) {
			jump('index.php?page=home');
		} else {
			Messages::addError('Datele introduse sunt incorecte!');
		}
	}

	$smarty->assign('CONTENT', 'components/login.tpl');
