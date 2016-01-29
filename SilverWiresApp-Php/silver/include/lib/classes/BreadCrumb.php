<?php

	/**
	 * Class: BreadCrumb
	 * 
	 * ex: 
	 * $breadCrumb = new BreadCrumb();
	 * $breadCrumb->add('Home', 'index.php?page=home');
	 * $breadCrumb->add('Test') // link null
	 * $smarty->assign('breadCrumb', $breadCrumb->getHtml());
	 * 
	 * @author Jumpeye Creative Media
	 * @copyright (C) Copyright 2001-2007 Jumpeye Creative Media http://www.jumpeye.com. All rights reserved.
	 *
	 */
	class BreadCrumb 
	{

		var $separator 	= ' &raquo; ';
		var $crumbs 	= array();

		/**
		 * Constructor
		 *
		 * @param string $separator - default &raquo;
		 * @return BreadCrumb
		 */
		public function __construct($separator = ' &raquo; ')
		{
			$this->setSeparator($separator);
		}

		/**
		 * Seteaza separatorul dintre linkuri
		 *
		 * @param unknown_type $separator
		 */
		public function setSeparator($separator)
		{
			$this->separator = $separator;
		}

		/**
		 * Adauga un nou link la Breadcrumb, 
		 *
		 * @param string $text - textul care va fi afisat in pagina
		 * @param string $link - link-ul la care se va duce
		 */
		public function add($text, $link = null)
		{
			$this->crumbs[] = array('link' => $link, 'text' => $text);
		}

		/**
		 * Returneaza html-ul cu breadcrumb
		 *
		 * @return string
		 */
		public function getHtml()
		{
			$ret = array();

			foreach ($this->crumbs as $crumb){
				$ret[] = $this->_getHref($crumb['text'], $crumb['link']);
			}

			return implode($this->separator, $ret);
		}

		private function _getHref($text, $link = null)
		{
			if(is_null($link)) {
				return '<span>' . $text . '</span>';
			}

			return '<a href="' . Application::getMappedPath($link) . '">' . $text . '</a>';
		}
	}
