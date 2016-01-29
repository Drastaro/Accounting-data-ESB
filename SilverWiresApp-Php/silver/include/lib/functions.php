<?php

	function getDateMysql($timeStamp = null)
	{
		if (is_null($timeStamp)){
			return date("Y-m-d H:i:s");
		} else {
			return date("Y-m-d H:i:s", $timeStamp);
		}
	}

	function reloadPage()
	{
		jump($_SERVER['REQUEST_URI']);
	}

	function generateUniqueHash ($char, $id)
	{
		$string = md5(microtime() . rand(0, 999999)) . $char . $id;
		$string = substr($string, strlen($string) - 16);
		return $string;
	}
	
	function generateHash ($len = 32)
	{
		return substr(md5(microtime() . rand(0, 999999)), 0, $len);
	}
	
	if (!function_exists('gzdecode')){
		function gzdecode($data){
			$g=tempnam('/tmp','ff');
			@file_put_contents($g,$data);
			ob_start();
			readgzfile($g);
			$d=ob_get_clean();
			@unlink($g);
			return $d;
		}
	}

	/** truncate un string
	 * 
	 * @param $string
	 * @param $length
	 * @param $etc
	 * @param $break_words
	 * @param $middle
	 * @return string
	 */
	function truncate($string, $length = 80, $etc = '...',
                                  $break_words = false, $middle = false)
	{
	    if ($length == 0)
	        return '';
	
	    if (strlen($string) > $length) {
	        $length -= strlen($etc);
	        if (!$break_words && !$middle) {
	            $string = preg_replace('/\s+?(\S+)?$/', '', substr($string, 0, $length+1));
	        }
	        if(!$middle) {
	            return substr($string, 0, $length).$etc;
	        } else {
	            return substr($string, 0, $length/2) . $etc . substr($string, -$length/2);
	        }
	    } else {
	        return $string;
	    }
	}

	/** scoate ./\ din fata stringului
	 * 
	 * @param $fname string
	 * @return string
	 */
	function safeFileName($fname)
	{
		return ltrim($fname, './\\');
	}

	/*
	 * mysql_real_escape_string 
	 */
	function realEscapeString($string)
	{
		static $q = null;
		if (is_null($q)){
			$q = new DbMySql();
		}
		return $q->realEscape($string);
	}
	
	/**
	 * realEscapeArray using mysql_real_escape_string
	 *
	 * @param array $array
	 */
	function realEscapeArray(&$array) {
		static $q = null;
		if (is_null($q)){
			$q = new DbMySql();
		}
		foreach ($array as &$value) {
			if (!is_array($value)) {
				$value = $q->realEscape($value);
			} else {
				realEscapeArray($value);
			}
		}
	}

	/**
	 * Curata HTML-ul...ideal pentru un htmlarea care restrictioneaza accesul pentru doar cateva taguri.
	 * Vezi http://php.net/strip_tags pentru mai multe detalii.
	 */
	function strip_tags_attributes($sSource, $aAllowedTags)
	{
		if(empty($aAllowedTags)) {
			return strip_tags($sSource);
		}

		if (is_array($aAllowedTags)){
			$aAllowedTags = '<' . implode('><', $aAllowedTags) . '>';
		}
		
		$sSource = htmlspecialchars_decode($sSource);

		$aDisabledAttributes = array('onabort', 'onactivate', 'onafterprint', 'onafterupdate', 
		'onbeforeactivate', 'onbeforecopy', 'onbeforecut', 'onbeforedeactivate', 'onbeforeeditfocus', 
		'onbeforepaste', 'onbeforeprint', 'onbeforeunload', 'onbeforeupdate', 'onblur', 'onbounce', 
		'oncellchange', 'onchange', 'onclick', 'oncontextmenu', 'oncontrolselect', 'oncopy', 'oncut', 
		'ondataavaible', 'ondatasetchanged', 'ondatasetcomplete', 'ondblclick', 'ondeactivate', 'ondrag', 
		'ondragdrop', 'ondragend', 'ondragenter', 'ondragleave', 'ondragover', 'ondragstart', 'ondrop', 
		'onerror', 'onerrorupdate', 'onfilterupdate', 'onfinish', 'onfocus', 'onfocusin', 'onfocusout', 
		'onhelp', 'onkeydown', 'onkeypress', 'onkeyup', 'onlayoutcomplete', 'onload', 'onlosecapture', 
		'onmousedown', 'onmouseenter', 'onmouseleave', 'onmousemove', 'onmoveout', 'onmouseover', 
		'onmouseup', 'onmousewheel', 'onmove', 'onmoveend', 'onmovestart', 'onpaste', 'onpropertychange', 
		'onreadystatechange', 'onreset', 'onresize', 'onresizeend', 'onresizestart', 'onrowexit', 
		'onrowsdelete', 'onrowsinserted', 'onscroll', 'onselect', 'onselectionchange', 'onselectstart', 
		'onstart', 'onstop', 'onsubmit', 'onunload');
		
		$disabledAtributesValue = array('javascript', 'position', 'float');
		#$sSource = preg_replace('/(&#|&#x)((\d|[a-fA-F]|;)+)/i', '', $sSource);
		
		preg_match_all('/&#(x?[0-9a-f]+);?/i', $sSource, $matches);
		
		if (!empty($matches[1])){
			foreach ($matches[1] as $k => $v){
				$sSource = str_replace($matches[0][$k], chr(intval($v)), $sSource);
			}
		}

		$sSource = str_replace(array("\n\r", "\n", "\r"), ' ', $sSource);

		$search = array('@<script[^>]*?>.*?</script>@si',  // Strip out javascript
               '@<style[^>]*?>.*?</style>@siU',    // Strip style tags properly
               '@<![\s\S]*?--[ \t\n\r]*>@'        // Strip multi-line comments including CDATA
		);
		$sSource = preg_replace($search, '', $sSource);

		$disabledAtributesValue = implode('|', $disabledAtributesValue);
		 
		return preg_replace('/<(.*?)>/ie', 
		"'<' . preg_replace(array('/(" . $disabledAtributesValue . "):[^\"\';]*/i', '/(" . implode('|', $aDisabledAttributes) . ")=[\"\'][^\"\']*[\"\']/i', '/\s+/'), array('', '', ' '), stripslashes('\\1')) . '>'", 
		strip_tags($sSource, $aAllowedTags));
	}

	/**
	 * Testeaza daca tipul sistemului de operare este Windows sau nu...
	 */
	function is_win_os()
	{
		return (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN');
	}

	/**
	 * Porneste o comanda in background...
	 * in functie de sistemul de operare.
	 * important: nu face escape la comanda/argumente!!!!
	 */
	function exec_background($command)
	{
		if(is_win_os()) {
			$WshShell = new COM("WScript.Shell"); // use built-in COM objects
			$oExec = $WshShell->Run($command, 0, false);
		} else {
			exec($command . ' > /dev/null &');
		}
	}

	/**
	 * 
	 * Sterge un dir. recursiv.
	 * Preluat de pe php.net.
	 *
	 */
	function removeDirectory($path)
	{
		// Add trailing slash to $path if one is not there
		if (substr($path, -1, 1) != DIRECTORY_SEPARATOR) {
		   $path .= DIRECTORY_SEPARATOR;
		}

		$normal_files = glob($path . "*");
		$hidden_files = glob($path . "\.?*"); // *nix systems
		if(!$normal_files) $normal_files = array();
		if(!$hidden_files) $hidden_files = array();

		$list = array_merge($normal_files, $hidden_files);
        if (!empty($list)) {

			#stergem:
			foreach ($list as $file) {
				# Skip pseudo links to current and parent dirs (./ and ../).
				if (preg_match("/(\.|\.\.)$/", $file))
				{
					continue;
				}

				(is_dir($file) && !is_link($file)) ? removeDirectory($file) : unlink($file);
	        }
		}

		if(is_dir($path)) {
			rmdir($path);
		}

		// TODO: o versiune care sterge o struct. de directoare folosind exec() si comenzi specifice SO-ului
	}

	/**
	 * Face redirect la locatia specificata in $url.
	 * Daca este specificat un status redirectul se va face corespunzator.
	 * Doar 301 si 302 sunt permise pt status.
	 *
	 * @param string $url
	 * @param integer $status
	 */
	function redirect($url, $status = null)
	{
		if(!is_null($status)) {
			if($status == 301) {
				header("HTTP/1.1 301 Moved Permanently");
			} else if($status == 302){
				header("HTTP/1.1 302 Moved Temporarily");
			}
		}

		header("Location: {$url}");
		die;
	}

	/**
	 * Forteaza un redirect la adresa specificata, prin diverse metode.
	 * Daca nu s-a facut inca output, se face redirect HTTP.
	 * Altfel se face redirect prin meta-refresh si/sau javascript.
	 *
	 * E doar o metoda de a te impusca singur in picior.
	 *
	 * @deprecated
	 *
	 * @param string $url
	 */
	function force_redirect($url)
	{
		if(headers_sent()) {
			echo '<META HTTP-EQUIV="refresh" content="0;URL='.htmlentities(urlencode($url)).'">';
			echo '<SCRIPT TYPE="text/javascript"> location.href="'.urlencode($link).'"; </SCRIPT>';
			die;
		} else {
			header("Location: {$url}");
			die;
		}
	}

	/**
	 * Face un redirect HTTP la url-ul indicat.
	 * Este metoda recomandata de a face redirecturi.
	 *
	 * Daca s-a facut output deja, se va afisa un warning.
	 *
	 * @param string $link
	 */
	function jump($link)
	{
		if ($link == -1) {
			$link = $_SERVER['HTTP_REFERER'];
		}
		header('Location: '.$link);
		die;
	}

	/**
	 * Genereaza un string aleator din cifre, litere mari si mici, de lungimea specificata. Default 8 caractere.
	 * Util pentru resetare de parole, creare de account-uri, etc.
	 *
	 * @param integer $length
	 * @param boolean $onlyAlphaNumeric
	 * @return string
	 */
	function randomPassword($length = 8, $onlyAlphaNumeric = false)
	{
		$str = '';
		for($i = 0; $i < $length; $i++) {
			$char = rand(48, 122);
			if ($onlyAlphaNumeric){
				$ok = false;
				while (!$ok){
					if (($char > 57 && $char < 65) || ($char > 90 && $char < 97)){
						$char = rand(48, 122);
					} else {
						$ok = true;
					}
				}
			}
			$str .= chr($char);
		}

		return $str;
	}

	/**
	 * Returneaza true daca browserul care a facut requestul curent suporta Content-Encoding-ul specificat.
	 * Evident nu functioneaza din linie de comanda.
	 * Valori posibile: gzip, deflate, zlib
	 *
	 * @param string $encoding
	 * @return boolean
	 */
	function browser_supports_encoding($encoding)
	{
		$accept_encoding = trim(@$_SERVER['HTTP_ACCEPT_ENCODING']);
		if($accept_encoding) {
			return false;
		}

		if($accept_encoding == '*') {
			return true;
		}

		$encodings = explode(',', $accept_encoding);
		$encoding = strtolower($encoding);
		foreach($encodings as $k => $v) {
			$v = trim($v);
			if(empty($v)) {
				continue;
			}

			$enc = explode(';', $v);
			$enc = strtolower(trim($enc[0]));

			if($enc == $encoding) {
				return true;
			}
		}

		return false;
	}

	/**
	 * Returneaza un array cu browserele care pot fi detectate usor din User-Agent.
	 * Este folosita de get_browser_id si get_browser_name.
	 *
	 * @return array
	 */
	function get_browser_list()
	{
		$browser_names = array();

		$browser_names[1] = 'Netscape (Gecko/Netscape)';
		$browser_names[2] = 'Mozilla Firefox (Gecko/Firefox)';
		$browser_names[3] = 'Mozilla (Gecko/Mozilla)';
		$browser_names[4] = 'Opera (MSIE/Opera/Compatible)';
		$browser_names[5] = 'Internet Explorer (MSIE/Compatible)';
		$browser_names[6] = 'Others browsers';

		return $browser_names;
	}

	/**
	 * Parseaza simplu User-Agentul primit ca parametru, pentru a determina browserul.
	 * Foloseste get_browser_list pentru a returna nr-ul browserului din lista.
	 *
	 * @param string $user_agent
	 * @return integer
	 */
	function get_browser_id($user_agent)
	{
		if(strpos($user_agent, 'Gecko')) {
			if(strpos($user_agent, 'Netscape'))		return 1;
			if(strpos($user_agent, 'Firefox'))		return 2;
			return 3;
		}

		if(strpos($user_agent, 'MSIE')) {
			if(strpos($user_agent, 'Opera'))		return 4;
			return 5;
		}

		return 6;
	}

	/**
	 * Parseaza simplu User-Agentul primit ca parametru, pentru a determina browserul.
	 * Foloseste get_browser_list pentru a returna numele browserului.
	 *
	 * @param string $user_agent_or_id
	 * @return string
	 */
	function get_browser_name($user_agent_or_id = '')
	{
		if(!$user_agent_or_id) {
			$user_agent_or_id = $_SERVER['HTTP_USER_AGENT'];
		}

		$browsers = get_browser_list();
		if(is_integer($user_agent_or_id)) {	//id case...
			return $browsers[$user_agent_or_id];
		}

		if(strpos($user_agent_or_id, 'Gecko')) {
			if(strpos($user_agent_or_id, 'Netscape')) {
				return $browsers[1];
			}

			if(strpos($user_agent_or_id, 'Firefox')) {
				return $browsers[2];
			}

			return $browsers[3];
		}

		if(strpos($user_agent_or_id, 'MSIE')) {
			if(strpos($user_agent_or_id, 'Opera')) {
				return $browsers[4];
			}

			return $browsers[5];
		}

		return $browsers[6];
	}

	/**
	 * Face output la o variabila sub forma unui comentariu html.
	 *
	 * @param mixed $var
	 */
	function comment($var)
	{
		echo '<!-- ';
		print_r($var);
		echo " -->\n";
	}

	/**
	 * Face output la o variabila intr-un tag html PRE,
	 * pentru a fi mai lizibil outputul.
	 *
	 * @param mixed $var
	 */
	function deg($var, $vardump = false)
	{
		global $config;
		if(empty($config->debug_mode)) {
			return;
		}
		
		echo '<pre style="display:block; background:#fff; border: 2px solid red; color: #000; padding:5px;">';
		
		$output = '';
		if ($vardump || empty($var))
		{
			var_dump($var);
		}
		else if (is_scalar($var))
		{
			echo htmlspecialchars($var);
		}
		else
		{
			echo str_replace(array('<', '>'), array('&lt;', '&gt;'), print_r($var, true));
	    }

		echo "</pre>\n";
	}

	/**
	 * Face output la o variabila intr-un tag html PRE,
	 * apoi opreste executia scriptului.
	 *
	 * @param mixed $var
	 */
	function out($var)
	{
		deg($var);
		die;
	}

	/**
	 * Un fel de breakpoint din cod:
	 * Opreste executia scriptului si afiseaza linia si fisierul de unde a fost apelata functia.
	 *
	 * Cand $show_all este true, afiseaza toate fisierele de unde este apelata, recursiv.
	 * Foloseste debug_backtrace().
	 *
	 * @param boolean $show_all
	 */
	function stop($show_all = false)
	{

		global $config;
		if(empty($config->debug_mode)) {
			return;
		}

		$ret = debug_backtrace();

		if($show_all) {
			out($ret, true);
		}

		$ret = $ret[0];
		$line = $ret['line'];
		$file = $ret['file'];
		$ret = '<div>Stop: File: <b>'.$file.'</b>, Line: '.$line.'</div>';

		die($ret);
	}

	/**
	 * Primeste un numar variabil de parametrii pe care ii afiseaza pe rand intr-un tag html PRE.
	 * Afiseaza nu numai datele, ci si tipurile lor (foloseste var_dump).
	 *
	 */
	function dump()
	{

		global $config;
		if(empty($config->debug_mode)) {
			return;
		}

		$arg_list = func_get_args();
		echo '<pre>';

		foreach($arg_list as $val) {
			var_dump($val);
			echo "<br>\n";
		}

		echo '</pre>';
	}

	/**
	 * Transforma un string PHP intr-un string javascript, fara a genera erori de sintaxa.
	 *
	 * @param string $str
	 * @return string
	 */
	function js_escape_string($str)
	{
		$str = str_replace("\\","\\\\", $str); // replace backslash with \\
		$str = str_replace("'","\\\'", $str);  // replace an single quote with \'
		$str = str_replace("\"","\\\"", $str); // replace a double quote with \"
		$str = str_replace("\r","\\r", $str); // replace CR with \r;
		$str = str_replace("\n","\\n", $str); // replace LF with \n;

		return $str;
	}

	/**
	 * Transforma un array PHP intr-un array javascript, cu numele specificat.
	 * Nu adauga tagul html SCRIPT.
	 *
	 * @param array $arr
	 * @param string $name
	 * @return string
	 */
	function array_to_js($arr, $name)
	{
		if(!is_array($arr)) {
			$arr = array($arr);
		}

		$ret = "\nvar ".$name." = new Array();\n";
		foreach($arr as $k => $v) {
			$ret .= $name."['".js_escape_string($k)."'] = '".js_escape_string($v)."';\n";
		}

		return $ret;
	}

	/**
	 * Extrage extensia unui fisier din numele(sau path-ul)acestuia.
	 *
	 * @param string $filename
	 * @return string
	 */
	function file_extension($filename)
	{
		return strtolower(substr(strrchr($filename, '.'), 1));
	}

	/**
	 * Verifica daca un email este in format valid, folosind expresii regulate (POSIX).
	 *
	 * @param string $var
	 * @return boolean
	 */
	function valid_email($var)
	{
		return Valid::email($var);
	}

	/**
	 * Verifica daca un url este in format valid, folosind expresii regulate (POSIX).
	 *
	 * @param string $var
	 * @return boolean
	 */
	function valid_url($var)
	{
		return eregi("^(http|https)+(:\/\/)+[a-z0-9_-]+\.+[a-z0-9_-]", $var);
	}

	/**
	 * Transforma un string care reprezinta o data in format MySql Date/DateTime,
	 * intr-un timestamp PHP.
	 *
	 * @param string $db_date
	 * @return integer
	 */
	function date_stamp($db_date)
	{
		if(!$db_date || $db_date == '0000-00-00 00:00:00') {
			return 0;
		}

		@list($date, $time) = explode(' ', $db_date);

		if(empty($time)) {
			$hour = $min = $sec = 0;
		} else {
			@list($hour, $min, $sec) = explode(':', $time);
		}

		@list($year, $month, $day) = explode('-', $date);

		return @mktime($hour, $min, $sec, $month, $day, $year);
	}

	/**
	 * Transforma textu primit din textarea pentru afisare, fara sa fie necesar un tag html PRE.
	 * Afecteaza doar 'spatiile albe': spatiu, \t, \n, \r
	 *
	 * @param string $text
	 * @return string
	 */
	function transform_text($text)
	{

		$text = strip_tags($text);

		$text = str_replace('  ', ' &nbsp;', $text);	//inlocuim spatiile: 2 spatii = 1 spatiu + un &nbsp;

		$text = str_replace("\t", ' &nbsp; &nbsp;', $text);

		$text = str_replace("\r\n", '<br>', $text);
		$text = str_replace(array("\r", "\n"), '<br>', $text);

		return $text;
	}

	/**
	 * Returneaza true daca $str il contine pe $with in prima pozitie (la inceputul stringului).
	 *
	 * @param string $str
	 * @param string $with
	 * @return boolean
	 */
	function start_with($str, $with)
	{
		return (strpos($str, $with) === 0);
	}

	/**
	 * Returneaza true daca $str il contine pe $with in orice pozitie.
	 *
	 * @param string $mystring
	 * @param string $find
	 * @return boolean
	 */
	function contains($mystring, $find)
	{
		return (strpos($mystring, $find) !== false);
	}

	/**
	 * Testeaza daca url-ul dat ca parametru este un url absolut.
	 *
	 * @param string $url
	 * @return boolean
	 */
	function is_absolute_url($url)
	{
		return (strpos($url, 'http://') === 0) || (strpos($url, 'https://') === 0);
	}

	/**
	 * Testeaza daca url-ul dat ca parametru este absolut iar host-ul este diferit de cel specificat.
	 *
	 * @param string $url
	 * @param string $hostname
	 * @return boolean
	 */
	function is_external_url($url, $hostname)
	{
		return (is_absolute_url($url) && (strpos($url, $hostname) === false));
	}

	/**
	 * Testeaza daca url-ul dat ca parametru este de tip javascript.
	 * Este o metoda ne-recomandata pentru a atasa JavaScript la linkuri.
	 *
	 * @param string $url
	 * @param string $hostname
	 * @return boolean
	 */
	function is_javascript_url($url)
	{
		return (strpos(strtolower(trim($url)), 'javascript:') === 0);
	}

	/**
	 * Testeaza daca url-ul dat ca parametru este de tip Content-ID.
	 * Acestea sunt foloside in mesajele email cu atasamente.
	 *
	 * @param string $url
	 * @param string $hostname
	 * @return boolean
	 */
	function is_cid_url($url)
	{
		return (strpos(strtolower(trim($url)), 'cid:') === 0);
	}

	/**
	 * Testeaza daca un url este un link 'mailto'.
	 * Compatibil cu unele metode din smarty pt. encoding de emailuri.
	 *
	 * @param string $url
	 * @return boolean
	 */
	function is_mailto_url($url)
	{
		static $mailto = 'mailto:';
		static $mailto_encoded = "&#109;&#97;&#105;&#108;&#116;&#111;&#58;"; //compat with smarty mailto!!!

		$url = strtolower($url);
		return (strpos($url, $mailto) === 0 || strpos($url, $mailto_encoded) === 0);
	}

	/**
	 * Face include automat la toate fisierele dintr-un director specificat (path relativ).
	 * Este recomandabil sa se specifice ca $base_dir document root-ul sitului, pt. a evita confuziile.
	 *
	 * ATENTIE: daca fisierele care sunt incluse declara variabile globale, acestea vor fi vizibile doar
	 * in scopul functiei, ceea ce inseamna ca vor fi distruse la iesirea din functie. Cu alte cuvinte,
	 * aceste variabile NU pot fi accesate.
	 *
	 * @param string $dirs
	 * @param string $base_dir
	 */
	function includeDirectories($dirs, $base_dir = '')
	{
		if(!is_array($dirs)){
			$dirs = array($dirs);
		}

		if(!count($dirs)){
			return;
		}

		if(!$base_dir){
			$base_dir = './';
			/*
				$base_dir = getcwd(); // SAU:
				$base_dir = dirname(dirname(dirname(__FILE__)));	//dir. unde e index.php...???
			*/
		}
		$base_dir = rtrim($base_dir, DIRECTORY_SEPARATOR).DIRECTORY_SEPARATOR;

		foreach($dirs as $dirname){
			$dir_path = $base_dir.trim($dirname, '/').'/';

			$dh = opendir($dir_path);
			while(false !== ($file_name = readdir($dh))){
				$file_path = $dir_path.$file_name;

				if(is_file($file_path) && file_extension($file_name) == 'php'){
					include $file_path;
				}
			}

			closedir($dh);
		}
	}

	/**
	 * Returneaza toate variabilele globale cu exceptia celor rezervate: $_GET, ...
	 * Practic este o varianta prescurtata pentru lizibilitate.
	 *
	 * @return array
	 */
	function get_globals()
	{
		$ret = $GLOBALS;

		$ex = array('HTTP_POST_VARS', 'HTTP_GET_VARS', 'HTTP_COOKIE_VARS', 'HTTP_SERVER_VARS', 'HTTP_ENV_VARS', 'HTTP_POST_FILES',
					'_POST', '_GET', '_COOKIE', '_SERVER', '_ENV', '_FILES', '_REQUEST', '_SESSION', 'HTTP_SESSION_VARS');
		foreach($ex as $v) {
			unset($ret[$v]);
		}

		return $ret;
	}

	/**
	 * Afiseaza intr-un tag html PRE ceea ce returneaza get_globals
	 * (variabilele globale relevante, declarate de utilizator)
	 *
	 */
	function deg_globals()
	{
		deg(get_globals());
	}

	/**
	 * Citeste din baza de date (folosind configuratia curenta din DB_Sql) id-ul si un field dintr-o tabela,
	 * pentru a genera un array asociativ.
	 *
	 * Acesta poate fi folosit la generare dinamica de elemente html OPTION, in interiorul unui tag html SELECT.
	 *
	 * @param string $table
	 * @param string $field
	 * @param string $append
	 * @return array
	 */
	function get_db_values($table, $field, $append = '')
	{
		$query = "SELECT id, $field FROM $table";
		if($append) {
			$query .= ' '.$append;
		} else {
			$query .= " ORDER BY $field ASC";
		}

		$q = new DB_Sql($query);

		$ret = array();
		while($q->next_record()) {
			$ret[$q->f('id')] = $q->f($field);
		}

		return $ret;
	}
	
	function assignCommonVars() {
		global $smarty, $config, $page;
		
		#general vars:
		$smarty->assign('config', $config);
		$smarty->assign('page_meta', $config->page_meta);	
		$smarty->assign('page', $page);
		
		#messages
		$smarty->assign('messages', Messages::getMessages());
		
        if (Users::isLogged()) {
            #user
            $smarty->assign('user', Users::getLogged());
        }
		
		#post
		if (!empty($_SESSION['post'])) {
			$smarty->assign('post', $_SESSION['post']);
			unset($_SESSION['post']);
		}

		//lunile anului
		
		$smarty->assign('lunileAnului', TXT::$MONTHS);
	}
	
	
	function showPageNotFound() {
		global $smarty, $config;
		
		if (empty($smarty)) {
			$smarty = Application::getSmarty('/templates/', '/templates_c/');
		}
		
		header("HTTP/1.0 404 Not Found");
		$smarty->assign('CONTENT', 'components/not-found.tpl');
		
		$config->page_meta->title = '';
		$config->page_meta->keywords = '';
		$config->page_meta->description = '';
		
		assignCommonVars();
		
		$smarty->display('components/index.tpl');
		exit;
	}
	
	function toAscii($str, $replace=array(), $delimiter='-') {
		if( !empty($replace) ) {
			$str = str_replace((array)$replace, ' ', $str);
		}
	
		$clean = iconv('UTF-8', 'ASCII//TRANSLIT', $str);
		$clean = preg_replace("/[^a-zA-Z0-9\/_|+ -]/", '', $clean);
		$clean = strtolower(trim($clean, '-'));
		$clean = preg_replace("/[\/_|+ -]+/", $delimiter, $clean);
	
		return $clean;
	}
	
	function safeDirName () {
		 $args = func_get_args();
		 foreach ($args as &$a) {
		 	$a = preg_replace('/[\s]+/', '_', preg_replace('/[\W]+/', ' ', trim($a)));
		 }
		 return implode('_', $args);
	}
	
	function safeLinkName () {
		$args = func_get_args();
		foreach ($args as &$a) {
			$a = toAscii($a);
		}
		return implode('-', $args);
	}
	
	function cleanEmptyArrayValues (&$get) {
		$mod = false;
		
		foreach ($get as $k => $v) {
			if (is_array($v)) {
				if (count($v)) {
					if (cleanEmptyArrayValues($get[$k])) {
						$mod = true;
					}
				} else {
					unset($get[$k]);
					$mod = true;
				}
			} elseif (trim($v) == '') {
				unset($get[$k]);
				$mod = true;
			}
		}
		
		return $mod;
	}
	
	function getMonths () {
		return array(
			1 => 'Ianuarie',
			2 => 'Februarie',
			3 => 'Martie',
			4 => 'Aprilie',
			5 => 'Mai',
			6 => 'Iunie',
			7 => 'Iulie',
			8 => 'August',
			9 => 'Septembrie',
			10 => 'Octombrie',
			11 => 'Noiembrie',
			12 => 'Decembrie'
		);
	}
	
	// Generates a strong password of N length containing at least one lower case letter,
	// one uppercase letter, one digit, and one special character. The remaining characters
	// in the password are chosen at random from those four sets.
	//
	// The available characters in each set are user friendly - there are no ambiguous
	// characters such as i, l, 1, o, 0, etc. This, coupled with the $add_dashes option,
	// makes it much easier for users to manually type or speak their passwords.
	//
	// Note: the $add_dashes option will increase the length of the password by
	// floor(sqrt(N)) characters.
	
	function generateStrongPassword($length = 9, $add_dashes = false, $available_sets = 'luds')
	{
		$sets = array();
		if(strpos($available_sets, 'l') !== false)
			$sets[] = 'abcdefghjkmnpqrstuvwxyz';
		if(strpos($available_sets, 'u') !== false)
			$sets[] = 'ABCDEFGHJKMNPQRSTUVWXYZ';
		if(strpos($available_sets, 'd') !== false)
			$sets[] = '23456789';
		if(strpos($available_sets, 's') !== false)
			$sets[] = '!@#$%&*?';
	
		$all = '';
		$password = '';
		foreach($sets as $set)
		{
			$password .= $set[array_rand(str_split($set))];
			$all .= $set;
		}
	
		$all = str_split($all);
		for($i = 0; $i < $length - count($sets); $i++)
			$password .= $all[array_rand($all)];
	
		$password = str_shuffle($password);
	
		if(!$add_dashes)
			return $password;
	
		$dash_len = floor(sqrt($length));
		$dash_str = '';
		while(strlen($password) > $dash_len)
		{
			$dash_str .= substr($password, 0, $dash_len) . '-';
			$password = substr($password, $dash_len);
		}
		$dash_str .= $password;
		return $dash_str;
	}
