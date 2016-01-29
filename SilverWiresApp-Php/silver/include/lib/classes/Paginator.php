<?php

	/**
	 * Class: Paginator
	 * 
	 * ex: 
	 * $pag = new Paginator(100); // 100 numarul total de inregistrari. se poate seta si ulterios cu $pag->setTotalRecords(100);
	 * echo $pag->getNavigator();
	 * 
	 * @author Jumpeye Creative Media
	 * @copyright (C) Copyright 2001-2007 Jumpeye Creative Media http://www.jumpeye.com. All rights reserved.
	 *
	 */
	class Paginator
	{
		var $href = '';

		var $separator = '&nbsp;&nbsp;';
		var $htmlLeft = 'Precedenta';
		var $htmlRight = 'Următoarea';
		var $htmlFirst = 'Prima pag.';
		var $htmlLast = 'Ultima pag.';
		var $selectedClass = '';
		var $linksClass = '';
		var $showMargins = true; // cand este true, afiseaza link catre prima si ultima pagina

		var $recordsPerPage = 10;
		var $maxLinks = 9;
		var $pageVar = 'p';

		var $currentPage;
		var $totalRecords;

		var $rewriter = null;

		/**
		 * Constructor.
		 *
		 * @param int $total_rec - numarul total de inregistrari (obligatoriu)
		 * @param string $link - optional
		 * @param int $current_page - pagina curenta (optional). Daca nu este setat va fi calculata automat.
		 * @return Paginator
		 */
		function Paginator($total_rec = 0, $link = null, $current_page = null)
		{
			$this->setTotalRecords($total_rec);

			if(is_null($link)) {
				$this->setLink($this->_getCurrentLink());
			} else {
				$this->setLink($link);
			}

			if(is_null($current_page)) {
				$this->setCurrentPage($this->getUrlPage());
			} else {
				$this->setCurrentPage($current_page);
			}
		}

		/**
		 * Seteaza numarul toatal de inregistrari.
		 *
		 * @param int $total_rec
		 */
		function setTotalRecords($total_rec)
		{
			$total_rec = intval($total_rec);
			if($total_rec < 0) {
				$total_rec = 0;
			}

			$this->totalRecords = $total_rec;
		}

		/**
		 * Returneaza numarul total de inregistrari
		 *
		 * @return unknown
		 */
		function getTotalRecords()
		{
			return $this->totalRecords;
		}

		/**
		 * Seteaza linkul pt paginare.
		 *
		 * @param string $link
		 */
		function setLink($link)
		{
			$this->href = $link;
		}

		/**
		 * Returneaza linkul curent.
		 *
		 * @return string
		 */
		function getLink()
		{
			return $this->href;
		}

		/**
		 * Seteaza pagina curenta.
		 *
		 * @param int $page_no
		 */
		function setCurrentPage($page_no)
		{
			$page_no = intval($page_no);
			if($page_no < 1) {
				$page_no = 1;
			}

			$this->currentPage = $page_no;
		}

		/**
		 * Returneaza pagina curenta.
		 *
		 * @return int
		 */
		function getCurrentPage()
		{
			return intval($this->currentPage);
		}

		/**
		 * Arata cu ce inregistrare din baza de date va incepe LIMIT-ul
		 *
		 * @return int
		 */
		function getLimitStart()
		{
			return intval($this->recordsPerPage * ($this->currentPage - 1));
		}

		/**
		 * Returneaza numarul de inregistrari care va fi selectat din baza de date.
		 *
		 * @return int
		 */
		function getLimitCount()
		{
			return intval($this->recordsPerPage);
		}

		/**
		 * Returneaza sfarsitul LIMIT-ului
		 *
		 * @return int
		 */
		function getLimitEnd()
		{
			return intval($this->recordsPerPage * $this->currentPage);
		}

		/**
		 * Returneaza LIMIT-ul pt mysql_query ex: 0,15
		 *
		 * @return string
		 */
		function getLimit()
		{
			return $this->getLimitStart() . ', ' . $this->getLimitCount();
		}

		/**
		 * Returneaza numarul de inregistrari pe o pagina.
		 *
		 * @return int
		 */
		function getRecordsPerPage()
		{
			return intval($this->recordsPerPage);
		}

		/**
		 * Seteaza numarul de inregistrari pe o pagina
		 *
		 * @param int $n
		 */
		function setRecordsPerPage($n)
		{
			$n = intval($n);
			if($n < 1) {
				$n = 1;
			}

			return $this->recordsPerPage = $n;
		}

		/**
		 * Returneaza numarul total de pagini.
		 *
		 * @return int
		 */
		function getTotalPages()
		{
			return ceil($this->totalRecords/$this->recordsPerPage);
		}

		/**
		 * Seteaza variabila folosita pt paginare ($_GET['p'])
		 *
		 * @param string $page_var
		 */
		function setPageVar($page_var)
		{
			$this->page_var = $page_var;
		}

		/**
		 * Returneaza variabila din $_GET folosita pt paginare.
		 *
		 * @return string
		 */
		function getPageVar()
		{
			return $this->page_var;
		}

		/**
		 * Seteaza imagine, caracter, etc. pentru Left
		 *
		 * @param string $html
		 */
		function setHtmlLeft($html)
		{
			$this->htmlLeft = $html;
		}
		
		/**
		 * Seteaza imagine, caracter, etc. pentru Right
		 *
		 * @param string $html
		 */
		function setHtmlRight($html)
		{
			$this->htmlRight = $html;
		}

		/**
		 * Seteaza imaginea pentru Left
		 *
		 * @param string $link - calea spre imagine
		 */
		function setImgLeft($link)
		{
			$this->htmlLeft = '<img src="'.$link.'" border="0" alt="" />';
		}

		/**
		 * Seteaza imaginea pentru Right
		 *
		 * @param string $link - calea spre imagine
		 */
		function setImgRight($link)
		{
			$this->htmlRight = '<img src="'.$link.'" border="0" alt="" />';
		}

		/**
		 * Returneaza html-ul care este setat pentru butonul de Left
		 *
		 * @return string
		 */
		function getHtmlLeft()
		{
			return $this->htmlLeft;
		}

		/**
		 * Returneaza html-ul care este setat pentru butonul de Left
		 *
		 * @return string
		 */
		function getHtmlRight()
		{
			return $this->htmlRight;
		}

		/**
		 * Seteaza Html-ul pentru link-ul care duce la prima pagina
		 *
		 * @param string $html
		 */
		function setHtmlFirst($html)
		{
			$this->htmlFirst = $html;
		}
		
		/**
		 * Returneaza html-ul setat pentru link-ul care duce la prima pagina
		 *
		 * @return string
		 */
		function getHtmlFirst()
		{
			return $this->htmlFirst;
		}
		
		/**
		 * Seteaza Html-ul pentru link-ul care duce la ultima pagina
		 *
		 * @param string $html
		 */
		function setHtmlLast($html)
		{
			$this->htmlLast = $html;
		}

		/**
		 * Returneaza html-ul setat pentru link-ul care duce la ultima pagina
		 *
		 * @return string
		 */
		function getHtmlLast()
		{
			return $this->htmlLast;
		}

		/**
		 * Seteaza numarul maxim de pagini care vor fi afisate odata
		 *
		 * @param int $n
		 */
		function setMaxLinks($n)
		{
			$n = intval($n);
			if($n < 1) {
				$n = 1;
			}

			$this->maxLinks = $n;
		}

		/**
		 * Returneaza numarul maxim de pagini
		 *
		 * @return unknown
		 */
		function getMaxLinks()
		{
			return $this->maxLinks;
		}

		/**
		 * Seteaza clasa de css pentru pagina selectata
		 *
		 * @param string $class
		 */
		function setSelectedClass($class)
		{
			$this->selectedClass = $class;
		}

		/**
		 * Returneaza clasa setata pentru pagina selectata
		 *
		 * @return string
		 */
		function getSelectedClass()
		{
			return $this->selectedClass;
		}

		/**
		 * Seteaza clasa de css pentru link-uri
		 *
		 * @param string $class
		 */
		function setLinksClass($class)
		{
			$this->linksClass = $class;
		}

		/**
		 * Returneaza clasa setata pentru link-uri
		 *
		 * @return unknown
		 */
		function getLinksClass()
		{
			return $this->linksClass;
		}

		/**
		 * Seteaza separatorul dintre pagini
		 *
		 * @param string $separator
		 */
		function setSeparator($separator)
		{
			$this->separator = $separator;
		}

		/**
		 * Returneaza separatorul dintre pagini
		 *
		 * @return string
		 */
		function getSeparator()
		{
			return $this->separator;
		}

		/**
		 * Returneaza un obiect daca este setata
		 *
		 * @return object
		 */
		function getRewriter()
		{
			return $this->rewriter;
		}

		/**
		 * Seteaza obiectul care face rewrite, in clasa setata trebuie sa existe functia cu numele rewrite.
		 *
		 * @param object $rewriter
		 */
		function setRewriter($rewriter = null)
		{
			if(is_object($rewriter) && function_exists(array($rewriter, 'rewrite'))) {
				$this->rewriter = $rewriter;
			} else if(class_exists($rewriter) && function_exists(array($rewriter, 'rewrite'))) {
				$this->rewriter = new $rewriter;
			} else {
				$this->rewriter = null;
			}
		}

		/**
		 * Returneaza html-ul cu paginare.
		 *
		 * @return string
		 */
		function getHtml()
		{
			$total_pages = $this->getTotalPages();

			if ($total_pages < 2) {
				return '';
			}

			$ret = $this->separator;

			$current_page = $this->getCurrentPage();

			if ($this->maxLinks <= $total_pages) {
				$middle = floor($this->maxLinks/2);

				$start = $current_page - $middle;

				if ($start < 1) {
					$start = 1;
					$end = $this->maxLinks;
				} else {
					$end = $current_page + $middle;

					if ($end > $total_pages) {
						$start = max(1, $total_pages - $this->maxLinks);
						$end = $total_pages;
					}
				}
			} else {
				$start = 1;
				$end = $total_pages;
			}

			$selected_class = $this->selectedClass ? ' class="'.$this->selectedClass.'"' : '';
			$links_class = $this->linksClass ? ' class="'.$this->linksClass.'"' : '';

			for ($i = $start; $i <= $end; $i++) {
				if ($i == $current_page) {
					$ret .= '<span' . $selected_class . '>' . $i . '</span>';
				} else {
					$ret .= '<a href="' . $this->_getLink($i) . '"' . $links_class . '>' . $i .'</a>';
				}

				$ret .= $this->separator;
			}
			
			if ($current_page > 1) {
				if (empty($this->htmlLeft)) {
					$left_content = '&laquo';	
				} else {
					$left_content = $this->htmlLeft;
				}
				
				if ($start > 1) {
					$ret = $this->separator . '...' . $ret;
				}

				$left_link = $this->_getLink($current_page - 1);
				$ret = $this->separator . "<a class=\"prev\" href=\"{$left_link}\">{$left_content}</a>" . $ret;
			}

			if ($current_page < $total_pages) {
				if (empty($this->htmlLeft)) {
					$right_content = '&raquo';
				} else {
					$right_content = $this->htmlRight;
				}
				
				if ($end < $total_pages) {
					$ret = $ret . '...' . $this->separator;
				}

				$right_link = $this->_getLink($current_page + 1);
				$ret .= "<a class=\"next\" href=\"{$right_link}\">{$right_content}</a>" . $this->separator;
			}

			if($this->showMargins) {
				if ($start > 1) {
					$first_page_link = $this->_getLink(1);
					$first_page_content = $this->htmlFirst;

					$ret = $this->separator . "<a href=\"{$first_page_link}\">{$first_page_content}</a>" . $ret;
				}

				if ($end < $total_pages) {
					$last_page_link = $this->_getLink($total_pages);
					$last_page_content = $this->htmlLast;

					$ret .= "<a href=\"{$last_page_link}\">{$last_page_content}</a>" . $this->separator;
				}
			}

			return $ret;	
		}

		function getUrlPage()
		{
			return isset($_GET[$this->pageVar]) ? $_GET[$this->pageVar] : 1;
		}

		function _getCurrentLink()
		{
			$qs = $_GET;
			unset($qs[$this->pageVar]);
			$qs = http_build_query($qs);

			$link = '';
			if($qs) {
				$link .= '?'.$qs;
			}

			return $link;
		}

		function _getLink($page_no)
		{
			static $op = null;
			if(is_null($op)) {
				$op = (strpos($this->href, '?') !== false) ? '&' : '?';
			}

			$link = $this->href . $op . $this->pageVar . '=' . $page_no;

			if(!is_null($this->rewriter)) {
				$link = $this->rewriter->rewrite($link);
			}

			return $link;
		}
	}

