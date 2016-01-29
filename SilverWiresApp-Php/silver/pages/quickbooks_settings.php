<?php
if ($config->isPOST() && !empty($_POST['mode']))
{    
    switch ($_POST['mode'])
    {
		case 'save-qb':
            QuickBooksData::saveQuickbooksSettings($_POST,Users::getLogged());
            break;
		case 'disconnect-qb':
            QuickBooksData::disconnectQuickbooks($_POST,Users::getLogged());
            break;
		
    }
   jump(-1);
}


$quickBooksStatusResponse = QuickBooksData::getQuickbooksAuthStatus(Users::getLogged());
$smarty->assign('quickbooksStatus',$quickBooksStatusResponse['status']);
$smarty->assign('companyName',$quickBooksStatusResponse['companyName']);



$logParam="";
DBLogging::addLog("quickbooks-quickbooks","afisare", $logParam, Users::getLogged());

$smarty->assign('sw_AdminURL',$GLOBALS['config']->sw_admin_url);
$smarty->assign('sw_user_id',Users::getLogged()->sw_user_id);

$smarty->assign('CONTENT', 'pages/quickbooks/settings.tpl');