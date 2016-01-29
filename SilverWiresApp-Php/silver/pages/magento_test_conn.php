<?php
$result="false";
if ($config->isPOST())
{    
	try
	{
		$username = $_POST['mag_username'];
		$pass = $_POST['mag_pass'];
		$url = $_POST['mag_url'];
		$url= "http://".rtrim($url, "/")."/index.php/api/v2_soap?wsdl=1";
		
		$client = new SoapClient($url);
		$session = $client->login($username, $pass);
		$client->endSession($session);
		$result="true";
	}catch( Exception $oException) {	
		$result="false";
	}
}
echo $result;
die();
