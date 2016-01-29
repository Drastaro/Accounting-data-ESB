<?php

	/**
	 * Validator class.
	 *
	 * Author: Jumpeye Creative Media
	 *
	 * (C) Copyright 2005 Jumpeye Creative Media http://www.jumpeye.com. All rights reserved.
	 *                    
	 */
	
	class Valid {
		
		/**
		 * Verfica daca un mail este valid. Daca $mailCheckDns este true va verifica si daca  dns-ul este valid
		 *
		 * @param string $mail
		 * @param string $mailCheckDns
		 * @return boolean
		 */
		public static function email($mail, $mailCheckDns = false)
		{
			if( preg_match("/^([a-z0-9_\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+\.)*[a-z0-9_\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+@((((([a-z0-9]{1}[a-z0-9\-]{0,62}[a-z0-9]{1})|[a-z])\.)+[a-z]{2,6})|(\d{1,3}\.){3}\d{1,3}(\:\d{1,5})?)$/i", $mail) ) {
	    		if (!$mailCheckDns) {
	    			return true;
	    		}
	    		$host = explode('@', $mail);
	    		if(checkdnsrr($host[1].'.', 'MX') ) return true;
	    		if(checkdnsrr($host[1].'.', 'A') ) return true;
	    		if(checkdnsrr($host[1].'.', 'CNAME') ) return true;
	    	}
	    	return false;
    	}

		public static function integer($str)
		{
			return ctype_digit($str);
		}
		
		public static function dateTime($str)
		{
			return (bool) strtotime($str);
		}

    	/**
    	 * Verifica daca data este valida.
    	 *
    	 * @param unknown_type $date
    	 * @return unknown
    	 */
    	public static function date($date)
    	{
			@list($y, $m, $d) = explode('-', $date);
			if(empty($y) || empty($m) || empty($d)) {
				return false;
			}

			if(!ctype_digit($y) || !ctype_digit($m) || !ctype_digit($d)) {
				return false;
			}

			return checkdate($m, $d, $y);
    	}

    	/**
    	 * Verifica daca valoarea este un numar.
    	 *
    	 * @param mixed $number
    	 * @return boolean
    	 */
    	public static function number($number)
    	{
    		if (is_numeric($number)) {
    			return true;
    		}
    		return false;
    	}
    	
    	/**
    	 * Verifica daca un ip este valid
    	 *
    	 * @param unknown_type $ip
    	 * @return unknown
    	 */
    	public static function ip($ip)
    	{
			if (preg_match("/^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/", $ip)) {
				return true;
			}
			return false;
    	}

    	/**
    	 * Verifica daca ssn pt USA este valid.
    	 *
    	 * @param string $ssn
    	 * @return boolean
    	 */
    	public static function ssn($ssn)
    	{
    		$high_groups = null;
    		// remove any dashes, spaces, returns, tabs or slashes
    		$ssn = str_replace(array('-','/',' ',"\t","\n"), '', $ssn);

    		// check if this is a 9-digit number
    		if (!is_numeric($ssn) || strlen($ssn) != 9) {
    			return false;
    		}
    		$area   = substr($ssn, 0, 3);
    		$group  = intval(substr($ssn, 3, 2));
    		$serial = intval(substr($ssn, 5, 4));

    		if (!$high_groups) {
    			$high_groups = Valid::ssnGetHighGroups();
    		}
    		return Valid::ssnCheck($area, $group, $serial, $high_groups);
    	}

		/**
		* Returns a range for a supplied group number, which
		* is the middle, two-digit field of a SSN.
		* Group numbers are defined as follows:
		* 1 - Odd numbers, 01 to 09
		* 2 - Even numbers, 10 to 98
		* 3 - Even numbers, 02 to 08
		* 4 - Odd numbers, 11 to 99
		* @param int $groupNumber a group number to check, 00-99
		* @return int
		*/
    	public static function ssnGroupRange($groupNumber)
    	{
    		if (is_array($groupNumber)) {
    			extract($groupNumber);
    		}
    		if ($groupNumber < 10) {
    			// is the number odd?
    			if ($groupNumber % 2) {
    				return 1;
    			} else {
    				return 3;
    			}
    		} else {
    			// is the number odd?
    			if ($groupNumber % 2) {
    				return 4;
    			} else {
    				return 2;
    			}
    		}
    	}

    	/**
		* checks if a Social Security Number is valid
		* needs the first three digits and first two digits and the
		* final four digits as separate integer parameters
		* @param int $area 3-digit group in a SSN
		* @param int $group 2-digit group in a SSN
		* @param int $serial 4-digit group in a SSN
		* @param array $high_groups array of highest issued group numbers
		*                           area number=>group number
		*/
    	public static function ssnCheck($area, $group, $serial, $high_groups)
    	{
    		if (is_array($area)) {
    			extract($area);
    		}
    		// perform trivial checks
    		// no field should contain all zeros
    		if (!($area && $group && $serial)) {
    			return false;
    		}

    		// check if this area has been assigned yet
    		if (!isset($high_groups[$area])) {
    			return false;
    		}

    		$high_group = $high_groups[$area];

    		$high_group_range = Valid::ssnGroupRange($high_group);
    		$group_range = Valid::ssnGroupRange($group);

    		// if the assigned range is higher than this group number, we're OK
    		if ($high_group_range > $group_range) {
    			return true;
    		} elseif ($high_group_range < $group_range) {
    			// if the assigned range is lower than the group number, that's bad
    			return false;
    		} elseif ($high_group >= $group) {
    			// we must be in the same range, check the actual numbers
    			return true;
    		}

    		return false;
    	}
    	
    	public static function ssnGetHighGroups($uri = 'http://www.ssa.gov/employer/highgroup.txt', $is_text = false)
    	{
    		/**
			* Stores high groups that have been fetched from any given web page to
			* keep the load down if having to validate more then one ssn in a row
			*/
    		static $high_groups = array();
    		static $lastUri = '';

    		if ($lastUri == $uri && !empty($high_groups)) {
    			return $high_groups;
    		}
    		$lastUri = $uri;

    		if ($is_text) {
    			$source = $uri;
    		} else {
    			if (!$fd = @fopen($uri, 'r')) {
    				$lastUri = '';
    				trigger_error('Could not access the SSA High Groups file', E_USER_WARNING);
    				return array();
    			}
    			$source = '';
    			while ($data = fread($fd, 2048)) {
    				$source .= $data;
    			}
    			fclose($fd);
    		}

    		$lines =  explode("\n", preg_replace("[^\n0-9]*", '', $source));
    		$high_groups = array();
    		foreach ($lines as $line) {
    			if (ereg('^([0-9]{3})([0-9]{2})([0-9]{3})([0-9]{2})([0-9]{3})([0-9]{2})([0-9]{3})([0-9]{2})([0-9]{3})([0-9]{2})([0-9]{3})([0-9]{2})$', $line, $grouping)) {
    				$high_groups[$grouping[1]] =  $grouping[2];
    				$high_groups[$grouping[3]] =  $grouping[4];
    				$high_groups[$grouping[5]] =  $grouping[6];
    				$high_groups[$grouping[7]] =  $grouping[8];
    				$high_groups[$grouping[9]] =  $grouping[10];
    				$high_groups[$grouping[11]] =  $grouping[12];
    			}
    		}
    		return $high_groups;
    	}
    	
    	/**
    	 * Verifica daca este valid un numar de telefon 
    	 * din USA.
    	 *
    	 * @param string $number
    	 * @param boolean $requireAreaCode
    	 * @return boolean
    	 */
    	public static function phoneNumber($number, $requireAreaCode = true)
    	{
    		if ($number == '') {
    			return true;
    		}

    		if (!$requireAreaCode) {
    			// just seven digits, maybe a space or dash
    			if (preg_match('/^[2-9]\d{2}[- ]?\d{4}$/', $number)) {
    				return  true;
    			}
    		} else {
    			// ten digits, maybe  spaces and/or dashes and/or parentheses maybe a 1 or a 0..
    			if (preg_match('/^[0-1]?[- ]?(\()?[2-9]\d{2}(?(1)\))[- ]?[2-9]\d{2}[- ]?\d{4}$/',
    			$number)) {
    				return true;
    			}
    		}
    		return false;
    	}
    	
    	/**
    	 * Verifica daca o regiune din SUA este valida.
    	 * ex: AL, AK, AZ
    	 * @param unknown_type $region
    	 * @return unknown
    	 */
    	public static function region($region)
    	{
    		switch (strtoupper($region)) {
    			case 'AL':
    			case 'AK':
    			case 'AZ':
    			case 'AR':
    			case 'CA':
    			case 'CO':
    			case 'CT':
    			case 'DE':
    			case 'DC':
    			case 'FL':
    			case 'GA':
    			case 'HI':
    			case 'ID':
    			case 'IL':
    			case 'IN':
    			case 'IA':
    			case 'KS':
    			case 'KY':
    			case 'LA':
    			case 'ME':
    			case 'MD':
    			case 'MA':
    			case 'MI':
    			case 'MN':
    			case 'MS':
    			case 'MO':
    			case 'MT':
    			case 'NE':
    			case 'NV':
    			case 'NH':
    			case 'NJ':
    			case 'NM':
    			case 'NY':
    			case 'NC':
    			case 'ND':
    			case 'OH':
    			case 'OK':
    			case 'OR':
    			case 'PA':
    			case 'RI':
    			case 'SC':
    			case 'SD':
    			case 'TN':
    			case 'TX':
    			case 'UT':
    			case 'VT':
    			case 'VA':
    			case 'WA':
    			case 'WV':
    			case 'WI':
    			case 'WY':
    				return true;
    		}
    		return false;
    	}
    	
    	/**
    	 * Verifica daca un cod postal pt america este valid.
    	 *
    	 * @param string $postalCode
    	 * @return boolean
    	 */
    	public static function postalCode($postalCode)
    	{
    		return (bool)preg_match('/^[0-9]{5}((-| )[0-9]{4})?$/', $postalCode);
    	}
    	
    	/**
    	 * Verifica daca un url este valid.
    	 * http://www.google.com	-> Valid
    	 * www.google.com			-> Invalid
    	 * 
    	 * @param  string $url
    	 * @return boolean
    	 */
    	public static function uri($url, $options = null)
    	{
    		$strict = ';/?:@$,';
    		$domain_check = false;
    		$allowed_schemes = null;
    		if (is_array($options)) {
    			extract($options);
    		}
    		if (preg_match(
			             '&^(?:([a-z][-+.a-z0-9]*):)?                             # 1. scheme
			              (?://                                                   # authority start
			              (?:((?:%[0-9a-f]{2}|[-a-z0-9_.!~*\'();:\&=+$,])*)@)?    # 2. authority-userinfo
			              (?:((?:[a-z0-9](?:[-a-z0-9]*[a-z0-9])?\.)*[a-z](?:[a-z0-9]+)?\.?)  # 3. authority-hostname OR
			              |([0-9]{1,3}(?:\.[0-9]{1,3}){3}))                       # 4. authority-ipv4
			              (?::([0-9]*))?)                                        # 5. authority-port
			              ((?:/(?:%[0-9a-f]{2}|[-a-z0-9_.!~*\'():@\&=+$,;])*)*/?)? # 6. path
			              (?:\?([^#]*))?                                          # 7. query
			              (?:\#((?:%[0-9a-f]{2}|[-a-z0-9_.!~*\'();/?:@\&=+$,])*))? # 8. fragment
			              $&xi', $url, $matches)) {
    			$scheme = isset($matches[1]) ? $matches[1] : '';
    			$authority = isset($matches[3]) ? $matches[3] : '' ;
    			if (is_array($allowed_schemes) &&
    			!in_array($scheme,$allowed_schemes)
    			) {
    				return false;
    			}
    			if (!empty($matches[4])) {
    				$parts = explode('.', $matches[4]);
    				foreach ($parts as $part) {
    					if ($part > 255) {
    						return false;
    					}
    				}
    			} elseif ($domain_check && function_exists('checkdnsrr')) {
    				if (!checkdnsrr($authority, 'A')) {
    					return false;
    				}
    			}
    			if ($strict) {
    				$strict = '#[' . preg_quote($strict, '#') . ']#';
    				if ((!empty($matches[7]) && preg_match($strict, $matches[7]))
    				|| (!empty($matches[8]) && preg_match($strict, $matches[8]))) {
    					return false;
    				}
    			}
    			return true;
    		}
    		return false;
    	}
    	
    	/**
	     * Validates a credit card number
	     *
	     * If a type is passed, the card will be checked against it.
	     * This method only checks the number locally. No banks or payment
	     * gateways are involved.
	     * This method doesn't guarantee that the card is legitimate. It merely
	     * checks the card number passes a mathematical algorithm.
	     *
	     * @param string  $creditCard number (spaces and dashes tolerated)
	     * @param string  $cardType type/brand of card (case insensitive)
	     *               "MasterCard", "Visa", "AMEX", "AmericanExpress",
	     *               "American Express", "Diners", "DinersClub", "Diners Club",
	     *               "CarteBlanche", "Carte Blanche", "Discover", "JCB",
	     *               "EnRoute", "Eurocard", "Eurocard/MasterCard".
	     * @return bool   TRUE if number is valid, FALSE otherwise
	     * @access public
	     * @static
	     * @see Luhn()
	     */
    	public static function creditCard($creditCard, $cardType = null)
    	{
    		$cc = str_replace(array('-', ' '), '', $creditCard);
    		if (($len = strlen($cc)) < 13
    		|| strspn($cc, '0123456789') != $len) {

    			return false;
    		}

    		// Only apply the Luhn algorithm for cards other than enRoute
    		// So check if we have a enRoute card now
    		if (strlen($cc) != 15
    		|| (substr($cc, 0, 4) != '2014'
    		&& substr($cc, 0, 4) != '2149')) {

    			if (!Valid::Luhn($cc)) {
    				return false;
    			}
    		}

    		if (is_string($cardType)) {
    			return Valid::CardType($cc, $cardType);
    		}

    		return true;
    	}
    	
    	public static function Luhn($number)
    	{
    		$len_number = strlen($number);
    		$sum = 0;
    		for ($k = $len_number % 2; $k < $len_number; $k += 2) {
    			if ((intval($number{$k}) * 2) > 9) {
    				$sum += (intval($number{$k}) * 2) - 9;
    			} else {
    				$sum += intval($number{$k}) * 2;
    			}
    		}
    		for ($k = ($len_number % 2) ^ 1; $k < $len_number; $k += 2) {
    			$sum += intval($number{$k});
    		}
    		return ($sum % 10) ? false : true;
    	}

    	public static function cardType($creditCard, $cardType)
    	{
    		switch (strtoupper($cardType)) {
    			case 'MASTERCARD':
    			case 'EUROCARD':
    			case 'EUROCARD/MASTERCARD':
    				$regex = '5[1-5][0-9]{14}';
    				break;
    			case 'VISA':
    				$regex = '4([0-9]{12}|[0-9]{15})';
    				break;
    			case 'AMEX':
    			case 'AMERICANEXPRESS':
    			case 'AMERICAN EXPRESS':
    				$regex = '3[47][0-9]{13}';
    				break;
    			case 'DINERS':
    			case 'DINERSCLUB':
    			case 'DINERS CLUB':
    			case 'CARTEBLANCHE':
    			case 'CARTE BLANCHE':
    				$regex = '3(0[0-5][0-9]{11}|[68][0-9]{12})';
    				break;
    			case 'DISCOVER':
    				$regex = '6011[0-9]{12}';
    				break;
    			case 'JCB':
    				$regex = '(3[0-9]{15}|(2131|1800)[0-9]{11})';
    				break;
    			case 'ENROUTE':
    				$regex = '2(014|149)[0-9]{11}';
    				break;
    			default:
    				return false;
    		}
    		$regex = '/^' . $regex . '$/';

    		$cc = str_replace(array('-', ' '), '', $creditCard);
    		return (bool)preg_match($regex, $cc);
    	}

		public static function captcha($name, $key = null)
		{
			// pt. huseni lenesi...
			if($key === null && isset($_POST[$name])) {
				$key = $_POST[$name];
			}

			// pe viitor, ar trebui restructurata si bucata asta de cod...
			$ret = isset($_SESSION['captcha'][$name]) && ($_SESSION['captcha'][$name] == $key);

			# security!!!!!!!
			unset($_SESSION['captcha'][$name]);

			return $ret;
		}
	}
