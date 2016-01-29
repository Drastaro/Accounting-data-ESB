<?php 

$logParam="";
DBLogging::addLog("magento-quickbooks-log","afisare", $logParam, Users::getLogged());

$smarty->assign('sw_AdminURL',$GLOBALS['config']->sw_admin_url);
$smarty->assign('sw_user_id',Users::getLogged()->sw_user_id);

$smarty->assign('CONTENT', 'pages/magento_quickbooks/log.tpl');