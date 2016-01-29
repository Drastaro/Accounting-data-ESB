<?php

if (!empty($_GET['id'])) {
	$edit = true;
	$id = intval($_GET['id']);
} else {
	$edit = false;
	$id = null;
}

$breadCrumb->add('Companies', '?page=companies&action=list');
$breadCrumb->add($edit ? 'Editare' : 'Adăugare');

$res = new Companies($id);

if ($res->id) {
	$config->page_meta->title = $res->name . ' / Editare companie / ' . $config->page_meta->title;
} else {
	$config->page_meta->title = 'Adăugare companie / ' . $config->page_meta->title;
}

if ($config->isPOST()) {
	$res->setRecord($_POST);
	
	if (empty($res->name))
	{
		Messages::addError('Numele este obligatoriu.');
	}

	if (!Messages::areErrors()) {
		$res->save();
		
		Messages::addNotice('Datele companiei au fost salvate.');
		jump('?page=companies&action=list');
	}
}

$smarty->assign('res', $res);

$users = new Users;
$smarty->assign('users', $users->getAll("ORDER BY `first_name` ASC, `last_name` ASC"));
