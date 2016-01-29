<?php

	$currentPage = (isset($_GET['p'])) ? (int)$_GET['p'] : 1;
	
	$config->page_meta->title = 'Companies / ' . $config->page_meta->title;
	$breadCrumb->add('Companies');

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

    $companies = new Companies;
	
	$cond = '1';
	
	if(!empty($filters['id'])) {
		$cond .= " AND `{$companies->getTableName()}`.`id`='{$filters['id']}' ";
	}

    if(!empty($filters['user_id'])) {
        $cond .= " AND `{$companies->getTableName()}`.`user_id`='{$filters['user_id']}' ";
    }
	
	if(!empty($filters['name'])) {
		$cond .= " AND (MATCH(`{$companies->getTableName()}`.`name`) AGAINST('{$filters['name']}' IN BOOLEAN MODE)
						OR `{$companies->getTableName()}`.`name` LIKE '%{$filters['name']}%') ";
	}
	
	if (empty($filters['orderby_what']) || empty($filters['orderby_how'])) {
		$filters['orderby_what'] = 'id';
		$filters['orderby_how'] = 'DESC';
	}
	
    $orderBy = "`{$companies->getTableName()}`.`{$filters['orderby_what']}` {$filters['orderby_how']}";

	
	// pages
	$total = $companies->getCount(" WHERE {$cond} ");
	
	$paginator = new Paginator($total);
	$paginator->recordsPerPage = $filters['rezultate'];
	$limit = $paginator->getLimit();
	
	//$res = $user->getAll(" WHERE {$cond} ORDER BY {$orderBy} LIMIT {$limit} ");
	$res = $companies->getList(" WHERE {$cond} ORDER BY {$orderBy} LIMIT {$limit} ");
	//deg($res);die;
	
	$smarty->assign($filters);
	$smarty->assign('paginator', $paginator->getHtml());
	$smarty->assign('p', $currentPage);
	$smarty->assign('total', $total);
	$smarty->assign('currentURL', $paginator->getLink());
	
	$smarty->assign('res', $res);
