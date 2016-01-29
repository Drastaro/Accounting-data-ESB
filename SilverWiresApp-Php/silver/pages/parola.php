<?php

	if ($config->isPost())
	{
		$user = Users::getLogged();
		
		if (empty($_POST['pass1']) ||  md5(trim($_POST['pass1'])) != $user->password)
		{
			Messages::addError('Parola actuală nu este validă.');
		}
		else if (empty($_POST['pass2']) || strlen(trim($_POST['pass2'])) < 6)
		{
			Messages::addError('Parola noua trebuie sa contina minim 6 caractere.');
		}
		else if (empty($_POST['pass3']) || trim($_POST['pass2']) != $_POST['pass3'])
		{
			Messages::addError('Parola noua nu a fost confirmata corect.');
		}
		else
		{
			$user->password = md5(trim($_POST['pass2']));
			$user->update();
			Messages::addNotice('Parola a fost schimbata cu succes.');
			DBLogging::addLog("schimbare-parola","update successful", "", Users::getLogged());
		}
		
		jump(-1);
	
	}
	DBLogging::addLog("schimbare-parola","afisare", "", Users::getLogged());
	$smarty->assign('CONTENT', 'pages/parola.tpl');
