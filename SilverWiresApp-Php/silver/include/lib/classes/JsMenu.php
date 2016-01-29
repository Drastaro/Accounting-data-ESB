<?php

	define('JSMENU_VERTICAL', 1);
	define('JSMENU_HORIZONTAL', 2);

	/**
	 * Clasa generatoare de meniuri drop-down (suckerfish).
	 * Poate genera 2 tipuri de meniu: orizontale si verticale.
	 *
	 * Pentru ca meniul sa fie efectiv funtional, trebuie inclusa manual secventa
	 * corespunzatoare in template-ul principal.
	 *
	 */
	class JsMenu
	{
		var $type;
		var $items = array();

		/**
		 * Instantiaza un meniu.
		 * Tipul este relevant doar la meniul care le include pe toate.
		 * Pentru celelalte, tipul se adapteaza dupa tipul meniului parinte.
		 *
		 * @param integer $type
		 * @return JsMenu
		 */
		function JsMenu($type = null)
		{
			$this->setType($type);
			$this->resetItems();
		}

		/**
		 * Seteaza tipul meniului. A se folosi una dintre constantele:
		 * JSMENU_VERTICAL sau JSMENU_HORIZONTAL.
		 *
		 * @param integer $type
		 */
		function setType($type)
		{
			if(in_array($type, array(JSMENU_VERTICAL, JSMENU_HORIZONTAL))) {
				$this->type = $type;
			} else {
				$this->type = $this->getDefaultType();
			}
		}

		/**
		 * Returneaza tipul curent de meniu.
		 *
		 * @return integer
		 */
		function getType()
		{
			return $this->type;
		}

		/**
		 * Returneaza tipul default (vertical).
		 * Este statica.
		 *
		 * @return integer
		 */
		function getDefaultType()
		{
			return JSMENU_VERTICAL;
		}

		/**
		 * Returneaza item-urile curente adaugate in meniu.
		 *
		 * @return array
		 */
		function getItems()
		{
			return $this->items;
		}

		/**
		 * Sterge toate item-urile adaugate in meniu.
		 *
		 */
		function resetItems()
		{
			$this->items = array();
		}

		/**
		 * Adauga un item in meniu.
		 *
		 * Titlul este obligatoriu.
		 * Daca linkul lipseste, se va seta ca '#'.
		 * $name este util cand se doreste sa se adauge un submeniu la itemul curent.
		 * $extra se va adauga ca atribut(e) la elementul LI in care se situeaza linkul,
		 * pentru flexibilitate mai mare.
		 *
		 * @param string $title
		 * @param string $href
		 * @param string $name
		 * @param string $extra
		 */
		function add($title, $href = '#', $name = null, $extra = null)
		{
			$line['title'] = $title;
			$line['href'] = empty($href) ? '#' : $href;
			$line['extra'] = $extra;

			if(is_null($name)) {
				$this->items[]['link'] = $line;
			} else {
				$this->items[$name]['link'] = $line;
			}
		}

		/**
		 * Asociaza un alt meniu la o optiune din meniul curent.
		 * $menu trebuie sa fie o alta instanta a clasei JsMenu.
		 * Tipul lui $menu (vertical sau orizontal) nu va mai conta, pentru ca se va folosi automat
		 * tipul lui $this.
		 * $name este numele item-ului la care se doreste sa se adauge $menu.
		 * Nota: nu este obligatoriu sa se dea un nume itemului ca sa i se asocieze $menu.
		 * Pur si simplu se poate folosi indicele sau (numeric, crescator).
		 * Ex:
		 * $menu->addMenu($submenu, 'option_name'); //se adauga la itemul cu numele specificat
		 * $menu->addMenu($submenu, 7); //se adauga la al 8-lea item, dintre cele care NU au nume
		 *
		 * @param string $name
		 * @param JsMenu $menu
		 * @return boolean
		 */
		function addMenu($name, $menu)
		{
			if(!is_object($menu) || !is_callable(array($menu, 'getHtml'))) {
				return false;
			}

			if(!isset($this->items[$name]['link'])) {
				return false;
			}

			$this->items[$name]['menu'] = $menu;

			return true;
		}

		/**
		 * alias pentru functia getHtml
		 *
		 * @return string
		 */
		function toString()
		{
			return $this->getHtml();
		}

		/**
		 * Returneaza html-ul necesar pentru a functiona meniul (recursiv, returneaza si html-ul necesar pt meniurile
		 * adaugate la itemurile din $this).
		 * $level este folosit intern si nu e recomandabil sa fie specificat direct.
		 *
		 * @param integer $level - folosit intern.
		 * @return string
		 */
		function getHtml($level = 0)
		{
			$class = 'adxm';
			if($level == 0) {
				$class .= ' ' . (($this->type == JSMENU_HORIZONTAL) ? 'jumpeye_hmenu' : 'jumpeye_vmenu');
			}
			$class = ' class="' . $class . '"';

			$ret = '<ul' . $class . '>';

			foreach($this->items as $name => $item) {

				if(empty($item['link'])) {
					continue;
				}

				$extra = isset($item['link']['extra']) ? (' '.$item['link']['extra']) : '';

				$ret .= '<li' . $extra . '>';
				$ret .= '<a href="' . $item['link']['href'] . '" title="' . $item['link']['title'] . '">' . $item['link']['title'] . '</a>';

				if(isset($item['menu'])) {
					$menu = $item['menu'];
					$ret .= $menu->getHtml($level + 1);
				}

				$ret .= '</li>';
			}

			$ret .= '</ul>';

			return $ret;
		}

		function fromArray($items)
		{
			$this->items = $items; // MWAHAHAHAHA!!!!
		}
	}
