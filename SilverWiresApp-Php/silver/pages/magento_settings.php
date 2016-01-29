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


$logParam="";
DBLogging::addLog("magento-settings","afisare", $logParam, Users::getLogged());

$smarty->assign('sw_AdminURL',$GLOBALS['config']->sw_admin_url);
$smarty->assign('sw_user_id',Users::getLogged()->sw_user_id);

$smarty->assign('CONTENT', 'pages/magento/settings.tpl');