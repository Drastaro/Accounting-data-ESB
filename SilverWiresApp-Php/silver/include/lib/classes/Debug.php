<?php
/**
 * Debug Class
 *
 * @name: Debug.php
 * @author: Zuzu
 * @copyright: Jumpeye Creative Media 2009
 */

class Debug
{
	/**
	 * Log DB Method
	 * 
	 * @param int $code
	 * @param string $msg
	 */
	public static function logDB ($code, $msg = '') {
		$q = new DbMySql();
		$code = intval($code);
		$date = date('Y-m-d H:i:s');
		$msg = $q->realEscape($msg);
		$q->query("INSERT INTO `log` SET `code`='{$code}', `date`='{$date}', `message`='{$msg}'");
	}
	
	public static function errorHandler ($errno, $errstr, $errfile, $errline) {
		$q = new DbMySql();
		$date = date('Y-m-d H:i:s');
		$err = $q->realEscape("Error {$errno}: '{$errstr}' IN {$errfile} ON LINE {$errline}");
		$q->query("INSERT INTO `log` SET `code`='99', `date`='{$date}', `message`='{$err}'");
	}
}
