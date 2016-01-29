<?php
 
$api_url_v1 = "http://www.magento1.com/api/soap/?wsdl=1";
 
$username = 'soapuser';
$password = '123456';
 
$cli = new SoapClient($api_url_v1);
 
//retreive session id from login
$session_id = $cli->login($username, $password);
 
//call customer.list method
$result = $cli->call($session_id, 'silverwires_api.swlisttaxes', array(array()));
//$result = $cli->call($session_id, 'quickbookswire_api.swlisttaxes', array(array()));

$cli->endSession($session_id);	

echo $result;

die();

