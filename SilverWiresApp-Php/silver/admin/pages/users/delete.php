<?php

if (empty($_GET['id'])) {
	jump(-1);
}

$res = new Users($_GET['id']);

if ($res->id) {
    $res->delete();
	Messages::addNotice('Userul a fost șters.');
}

jump(-1);
