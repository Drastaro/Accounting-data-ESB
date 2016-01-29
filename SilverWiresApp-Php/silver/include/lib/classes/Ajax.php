<?php

/**
 * Ajax Class
 * 
 * @name Ajax.php
 * @author Zuzu
 * @copyright Jumpeye Creative Media 2009
 */
class Ajax
{
	static
		$type = 'json'; 
	
	/**
	 * Output Response
	 *
	 * @param int $code
	 * @param mixed $response
	 */
	public static function output ($response)
	{
		$result = json_encode(array(	'code'	=> 200,
										'data'	=> $response));
		Ajax::_out($result);
	}
	
	public static function internalServerError($error = null)
	{
		header('HTTP/1.0 500 Internal Server Error');
		Ajax::_out(json_encode($error));
		exit();
	}
	
	/**
	 * Output Error Response
	 *
	 * @param int $code
	 * @param mixed $response
	 */
	public static function outputError ($errorMessage, $code = 500)
	{
		$result = json_encode(
			array(
				'code'	=> $code,
				'data'	=> $errorMessage
			)
		);
		Ajax::_out($result);
		exit;
	}
	
	public static function _out($data)
	{
		switch (Ajax::$type){
			default:
				echo $data;
				break;
				
			case 'jsonp':
				if (isset($_REQUEST['callback'])){
					echo $_REQUEST['callback'] . '(' . $data . ');';
				} else {
					echo $data;
				}
				break;
		}
		
		exit();
	}
	
}
