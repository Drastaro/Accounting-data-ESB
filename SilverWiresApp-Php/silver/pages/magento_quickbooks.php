<?php
if ($config->isPOST() && !empty($_POST['mode']))
{    
    switch ($_POST['mode'])
    {
        case 'save-magento':
            MagentoData::saveData($_POST,Users::getLogged());
            break;
		case 'edit-magento':
            MagentoData::saveData($_POST,Users::getLogged());
            break;
		case 'save-qb':
            QuickBooksData::saveQuickbooksSettings($_POST,Users::getLogged());
            break;
		case 'disconnect-qb':
            QuickBooksData::disconnectQuickbooks($_POST,Users::getLogged());
            break;
		
    }
   jump(-1);
}
$magentoData = MagentoData::getMagentoDataByUserId(Users::getLogged());
if($magentoData!=null) {
	$smarty->assign('magentoData', $magentoData);
	$smarty->assign('mode', 'edit-magento');
} else {
	$smarty->assign('magentoData', new MagentoData());
	$smarty->assign('mode', 'save-magento');
}

$quickbooksStatus = QuickBooksData::getQuickbooksAuthStatus(Users::getLogged());
$smarty->assign('quickbooksStatus',$quickbooksStatus);
if($quickbooksStatus=="connected") {
	$quickbooksSettings = QuickBooksData::getQuickbooksSettings(Users::getLogged());
	$smarty->assign('companyName',$quickbooksSettings['companyName']);
	$smarty->assign('incomeAccounts',$quickbooksSettings['incomeAccounts']);
	$smarty->assign('qbTaxes',$quickbooksSettings['qbTaxes']);
	$smarty->assign('magentoTaxes',$quickbooksSettings['magentoTaxes']);	
	$smarty->assign('selectedIncomeAccountId',$quickbooksSettings['selectedIncomeAccountId']);
	
	//the taxes mapping is a json with infex for magento tax id and value for qb tax id => transform that into an array
	
	$smarty->assign('taxesMapping',json_decode($quickbooksSettings['magQBTaxesMapping'], true));
	
}


$logParam="";
DBLogging::addLog("magento-quickbooks","afisare", $logParam, Users::getLogged());

$smarty->assign('sw_AdminURL',$GLOBALS['config']->sw_admin_url);
$smarty->assign('sw_user_id',Users::getLogged()->sw_user_id);

$smarty->assign('CONTENT', 'pages/magento_quickbooks/setup.tpl');