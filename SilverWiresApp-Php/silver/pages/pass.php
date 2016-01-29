<?php

if (Users::isLogged()) {
	jump('/');
}

$secu = new SecurityHash;

if (!empty($_GET[0])) {
	$secu->readField('hash', $_GET[0]);
}

if (empty($secu->id) || !$secu->isValid()) {
	showPageNotFound();
}

if ($config->isPOST())
{
	if (empty($_POST['p1']) || strlen(trim($_POST['p1'])) < 6)
	{
		Messages::addError('Parola trebuie să conțină minim 6 caractere.');
	}
	else if (empty($_POST['p2']) || trim($_POST['p1']) != $_POST['p2'])
	{
		Messages::addError('Parola nu a fost confirmată corect.');
	}
    /*
	else if (empty($_POST['code']) || trim(strtolower($_POST['code'])) != $secu->confirmation_code)
	{
		Messages::addError('Codul de confirmare nu este valid.');
	}
    */
	else
	{
		$res = new Users;
		$res->readField('email', $secu->email);
		
		if ($res->id) {
			$res->password = md5($_POST['p1']);
			$res->confirmed = 1;
			$res->update();
			
			if ($secu->isSignup())
			{
				Users::login($res->email, $_POST['p1']);
			}
			else
			{
				Messages::addNotice('Parola a fost schimbată cu succes. Puteți să vă autentificați folosind noua parolă.');
			}
			
			$secu->delete();
			
			jump('/');
		}
	}	
}

$smarty->assign('secu', $secu);
$smarty->assign('CONTENT', 'pages/pass.tpl');