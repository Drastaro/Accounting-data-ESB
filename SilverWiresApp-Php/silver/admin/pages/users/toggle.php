<?php

if (empty($_GET['id'])) {
	jump(-1);
}

$res = new Users($_GET['id']);

if ($res->id) {
	if ($res->isActive == 1) {
		$res->isActive = 0;
		$res->update();
		Messages::addNotice('Userul a fost dezactivat.');
		
	} else {
		$res->isActive = 1;
		$res->update();
		Messages::addNotice('Userul a fost activat.');
	}
}

jump(-1);
