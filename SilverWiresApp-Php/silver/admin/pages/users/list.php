<?php

	$currentPage = (isset($_GET['p'])) ? (int)$_GET['p'] : 1;
	
	$config->page_meta->title = 'Users / ' . $config->page_meta->title;
	$breadCrumb->add('Users');

	if (cleanEmptyArrayValues($_GET)) {
		$paginator = new Paginator;
		jump($paginator->getLink());
	}
	
	// filters
	$filters = $_GET;
	realEscapeArray($filters);
	
	if (empty($filters['rezultate']) || !is_numeric($filters['rezultate'])
		|| $filters['rezultate'] < 1 || $filters['rezultate'] > 1000)
	{
		$filters['rezultate'] = 50;
	}
	
	$cond = '1';
	
	if(!empty($filters['id'])) {
		$cond .= " AND `id`='{$filters['id']}' ";
	}
	
	if(!empty($filters['name'])) {
		$cond .= " AND (MATCH(`first_name`, `last_name`) AGAINST('{$filters['name']}' IN BOOLEAN MODE)
						OR CONCAT_WS(' ', `first_name`, `last_name`) LIKE '%{$filters['name']}%') ";
	}
	
	if(!empty($filters['email'])) {
		$cond .= " AND `email` LIKE '%{$filters['email']}%' ";
	}
	
	if(!empty($filters['phone'])) {
		$cond .= " AND `telephone` LIKE '%{$filters['phone']}%' ";
	}
	
	if(isset($filters['active']) && $filters['active'] != '') {
        $cond .= " AND `isActive` ='" . ($filters['active'] == 0 ? 0 : 1) . "' ";
	}

	if (empty($filters['orderby_what']) || empty($filters['orderby_how'])) {
		$filters['orderby_what'] = 'id';
		$filters['orderby_how'] = 'DESC';
	}
	
	if ($filters['orderby_what'] == 'name') {
		$orderBy = "CONCAT_WS(' ', `first_name`, `last_name`) {$filters['orderby_how']}";
	} else {
		$orderBy = "`{$filters['orderby_what']}` {$filters['orderby_how']}";
	}
	
	
	// pages
	$user = new Users();
	
	$total = $user->getCount(" WHERE {$cond} ");
	
	$paginator = new Paginator($total);
	$paginator->recordsPerPage = $filters['rezultate'];
	$limit = $paginator->getLimit();
	
	//$res = $user->getAll(" WHERE {$cond} ORDER BY {$orderBy} LIMIT {$limit} ");
	$res = $user->getList(" WHERE {$cond} ORDER BY {$orderBy} LIMIT {$limit} ");
	//deg($res);die;
	
	$smarty->assign($filters);
	$smarty->assign('paginator', $paginator->getHtml());
	$smarty->assign('p', $currentPage);
	$smarty->assign('total', $total);
	$smarty->assign('currentURL', $paginator->getLink());
	
	$smarty->assign('res', $res);
