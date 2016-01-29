<?php
	
	$action = isset($_GET['action']) ? $_GET['action'] : null;
	$id = isset($_GET['id']) ? $_GET['id'] : null;
	
	$adm = new Admin($id);

	switch ($action){
		default:
			showPageNotFound();
			break;
			
		case 'list':
			
			$config->page_meta->title = 'Administratori / ' . $config->page_meta->title;
			$breadCrumb->add('Administratori');
			
			$smarty->assign('administrators', $adm->getAll('ORDER BY `email` ASC'));
			
			break;
			
		case 'add_edit':
			
			if ($config->isPOST()){
				if (!empty($_POST['name'])){
					$adm->name = $_POST['name'];
				}
				if (!empty($_POST['email'])){
					$adm->email = $_POST['email'];
				}
				if (!empty($_POST['password'])){
					if ($_POST['password'] == $_POST['password2']) {
						$adm->password = md5($_POST['password']);
					} else {
						Messages::addError('Parola nu a fost reintrodusă corect !');
					}
				}
				$adm->access = isset($_POST['access']) ? array_sum($_POST['access']) : 0;
				if (empty($adm->id) && (empty($adm->email) || empty($adm->password) || empty($adm->name))){
					Messages::addError('Numele, e-mail-ul și parola sunt obligatorii !');
					jump(-1);
					
				} else {
					$adm->save();
					if ($adm->id == Admin::getLogged()->id){
						Admin::setLoggedUser($adm);
					}
					Messages::addNotice('Modificările au fost salvate.');
				}
				jump('?page=administrators&action=list');
			}
			
			$breadCrumb->add('Administratori', '?page=administrators&action=list');
			if ($adm->id) {
				$breadCrumb->add('Editare');
				$config->page_meta->title = $adm->email . ' / Editare administrator / ' . $config->page_meta->title;
			} else {
				$breadCrumb->add('Adăugare');
				$config->page_meta->title = 'Adăugare administrator / ' . $config->page_meta->title;
			}
			
			$smarty->assign('accessData', Admin::getAccessData());
			$smarty->assign('adm', $adm);
			
			break;
			
		case 'remove':
			
			$adm->delete();
			Messages::addNotice('Administratorul a fost șters.');
			jump(-1);
			break;
		
	}
	
	$smarty->assign('CONTENT', $page . '/' . $action . '.tpl');