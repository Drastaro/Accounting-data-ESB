<?php

	/**
	 * Clasa generalizata care poate sa pastreze o serie de proprietati.
	 * Proprietatile vor fi membrii publici ai clasei.
	 *
	 * Cele 3 proprietati predefinite nu este recomandabil sa fie modificate direct.
	 *
	 */
	class Config
	{
		var $is_command_line;
		var $absolute_path;
		var $absolute_url;

		/**
		 * Constructor
		 *
		 * @return Config
		 */
		function Config() {  }

		/**
		 * Returneaza locatia aboluta a sitului, folosind protocolul HTTPS.
		 * In linie de comanda valoarea returnata este necorespunzatoare(nu exista url).
		 *
		 * @return string
		 */
		function getHttpsUrl()
		{
			return 'https://'.$_SERVER['HTTP_HOST'].'/';
		}

		/**
		 * Testeaza daca requestul curent a fost facut prin HTTPS sau HTTP.
		 * In linie de comanda se returneaza false.
		 *
		 * @return boolean
		 */
		function isHttps()
		{
			return (!empty($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == '1') || (strtolower($_SERVER['HTTPS']) == 'on')));
		}

		/**
		 * Testeaza daca requestul curent a fost facut cu www in fata, in url.
		 * In linie de comanda rezultatul este irelevant.
		 *
		 * @return boolean
		 */
		function isWWW()
		{
			return (!$this->is_command_line) && (strpos($_SERVER['HTTP_HOST'], 'www.') === 0);
		}

		/**
		 * Testeaza daca requestul curent a fost facut prin POST.
		 * In linie de comanda rezultatul este irelevant.
		 *
		 * @return boolean
		 */
		function isPOST()
		{
			return ((!$this->is_command_line) && (strtoupper($_SERVER['REQUEST_METHOD']) == 'POST'));
		}

		/**
		 * Returneaza url-ul curent, exact cum a fost specificat in request. Este un url absolut.
		 * In linie de comanda rezultatul este irelevant.
		 *
		 * @return string
		 */
		function getCurrentUrl()
		{
			if($this->is_command_line) {
				return '';
			}

			$protocol = $this->isHttps() ? 'https://' : 'http://';
			return $protocol.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		}

		/**
		 * Returneaza url-ul curent, exact cum a fost specificat in request. Este un url relativ la /.
		 * In linie de comanda rezultatul este irelevant.
		 *
		 * @return string
		 */
		function getCurrentRelativeUrl()
		{
			if($this->is_command_line) {
				return '';
			}

			return $_SERVER['REQUEST_URI'];
		}

		/**
		 * Returneaza refererul, daca este setat: $_SERVER['HTTP_REFERER'];
		 * In linie de comanda rezultatul este irelevant.
		 *
		 * @return string
		 */
		function getRefererUrl()
		{
			if($this->is_command_line) {
				return '';
			}

			return @$_SERVER['HTTP_REFERER'];
		}
	}
