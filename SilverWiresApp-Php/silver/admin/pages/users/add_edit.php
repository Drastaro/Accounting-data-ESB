<?php

if (!empty($_GET['id'])) {
	$edit = true;
	$id = intval($_GET['id']);
} else {
	$edit = false;
	$id = null;
}

$breadCrumb->add('Users', '?page=users&action=list');
$breadCrumb->add($edit ? 'Editare' : 'Adăugare');

$res = new Users($id);

if ($res->id) {
	$config->page_meta->title = $res->getName() . ' / Editare user / ' . $config->page_meta->title;
} else {
	$config->page_meta->title = 'Adăugare user / ' . $config->page_meta->title;
}

if ($config->isPOST()) {
	$res->setRecord($_POST);
	
	if (empty($res->last_name))
	{
		Messages::addError('Numele este obligatoriu.');
	}
	else if (empty($res->first_name))
	{
		Messages::addError('Prenumele este obligatoriu.');
	}
	else if (empty($res->email))
	{
		Messages::addError('E-mail-ul este obligatoriu.');
	}
	else
	{
		$aux = $res->getAll(" WHERE `email`='" . realEscapeString($res->email) . "' ");
		$aux = array_values($aux);
		if (count($aux) > 1)
		{
			Messages::addError('E-mail-ul este deja atasat mai multor useri. Această problemă trebuie remediată de urgență!');
		}
		else if (count($aux) == 1 && $aux[0]->id != $res->id)
		{
			Messages::addError('E-mail-ul este deja atasat unui alt user.');
		}
	}
	
	if (!Messages::areErrors()) {
		if (empty($res->password)) {
			//$res->password = generateStrongPassword(6);
			$res->password = 0;
		}
        if (empty($res->id)) {
            $res->isActive = 1;
        }
		$res->save();
		
		Messages::addNotice('Datele userului au fost salvate.');
		jump('?page=users&action=list');
	}
}

$smarty->assign('res', $res);
