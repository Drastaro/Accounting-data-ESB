<?php

	/**
	 * Reprezinta o portiune de cod html, stocata intr-un fisier specificat. Poate fi doar o portiune de html dintr-o pagina,
	 * sau o pagina intreaga. Permite citirea si scrierea continutului.
	 * Face pereche buna cu FCKEditor, care este un generator de html.
	 *
	 */
	class HtmlContent
	{
		var $name = '';

		/**
		 * Constuctor
		 *
		 * @param string $name
		 * @return HtmlContent
		 */
		function HtmlContent($name)
		{
			$this->setName($name);
		}

		/**
		 * Returneaza numele fisierului in care se salveaza continutul.
		 *
		 * @return string
		 */
		function getName()
		{
			return $this->name;
		}

		/**
		 * Schimba numele fisierului.
		 *
		 * @param string $name
		 */
		function setName($name)
		{
			$this->name = $name;
		}

		/**
		 * Returneaza directorul setat implicit pentru salvarea fisierului.
		 * Toate fisierele vor fi salvate in acest director.
		 *
		 * Este statica, si se foloseste de variabila globala $config (instantiata in init.php)
		 * pentru a calcula root-ul sitului.
		 *
		 * @return string
		 */
		function getBasePath()
		{
			return $GLOBALS['config']->absolute_path.'/files/html/';
		}

		/**
		 * Returneaza path-ul absolut al fisierului.
		 *
		 * @return string
		 */
		function getAbsolutePath()
		{
			return HtmlContent::getBasePath().$this->name;
		}

		/**
		 * Returneaza codul html asociat cu fisierul, daca acesta exista.
		 *
		 * @return string
		 */
		function getContent()
		{
			return @file_get_contents($this->getAbsolutePath());
		}

		/**
		 * Actualizeaza continutul fisierului cu codul html specificat (suprascrie vechiul continut).
		 * Se face chmod la valoarea 0777 pentru a evita probleme de acces la fisier.
		 *
		 * @param string $content
		 */
		function updateContent($content)
		{
			$file_path = $this->getAbsolutePath();
			$f = @fopen($file_path, 'w');
			if($f){
				@fwrite($f, $content);
				fclose($f);
			}

			@chmod($file_path, 0777);
		}
	}
