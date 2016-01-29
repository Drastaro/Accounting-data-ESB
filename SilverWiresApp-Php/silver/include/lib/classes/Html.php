<?php

	/*
	 * Genereaza cod html in functie de variabile dinamice.
	 * Toate functiile sunt statice.
	 * ex, Html::select('foo', array( 1 => 'bar', 2 => 'bar2'));
	 *
	 */
	class Html
	{
		/**
		 * Genereaza cod html pentru un element SELECT, impreuna cu optiunile specificate.
		 * Primeste numele si id-ul specificat in $name.
		 * Optiunile generate sunt cele specificate in $options, care trebuie sa fie un array asociativ.
		 * Daca exista o valoare selectata, se va specifica in $selected_value.
		 * $extra, cand este specificat, se adauga elementului SELECT, ca atribut.
		 *
		 * @param string $name
		 * @param array $options
		 * @param string $selected_value
		 * @param string $extra
		 * @return string
		 */
		function select($name, $options = array(), $selected_value = null, $extra = null)
		{
			$extra = is_null($extra) ? '' : ' '.$extra;

			if(!is_array($selected_value)) {
				$selected_value = array($selected_value);
			} else {
				$extra .= ' multiple="multiple"';
			}

			$ret  = '<select name="'.$name.'" id="'.$name.'"'.$extra.'>';

			foreach($options as $value => $label) {
				$selected = in_array($value, $selected_value) ? ' selected="selected"' : '';
				$ret .= '<option value="'.$value.'"'.$selected.'>'.$label.'</option>';
			}

			$ret .= '</select>';

			return $ret;
		}

		/**
		 * Genereaza un element de tip calendar. Fisierele js/css corespunzatoare trebuiesc incluse manual in template.
		 * De asemenea, limba in care sunt afisate elementele calendarului trebuie setata manual.
		 *
		 * Numele fieldului va fi $name; daca se specifica $selected_date, fieldul va fi auto-completat.
		 * Daca $multiselect este true, se pot selecta mai multe date.
		 *
		 *
		 * @param string $name
		 * @param string $selected_date
		 * @param boolean $editable
		 * @param boolean $multiselect
		 * @return string
		 */
		function calendar($name, $selected_date = null, $multiselect = false) //foloseste js
		{
			$value = is_null($selected_date) ? '' : $selected_date;

			#$style = 'flat';
			$style = 'popup';

			$multiselect = $multiselect ? 'true' : 'false';

			$ret  = '<input name="'.$name.'" id="'.$name.'" value="'.$value.'" class="textField" 
			style="width:80px">';
			$ret .= "<script type=\"text/javascript\"> ".
						"new Epoch('{$name}', '{$style}', document.getElementById('{$name}'), {$multiselect})</script>";

			return $ret;
		}

		function editor($field_name, $field_value = '', $width = '600', $height = '400')
		{
			global $config;
			$path = $config->absolute_path . "/script/FCKeditor/";
			$url = $config->absolute_url . "script/FCKeditor/";

			require_once $path . 'fckeditor.php';

			$oFCKeditor = new FCKeditor($field_name);

			$oFCKeditor->BasePath = $url;
			$oFCKeditor->Config['CustomConfigurationsPath'] = $url . 'fckconfig.js';

			$oFCKeditor->Value = $field_value;
			$oFCKeditor->Width  = $width;
			$oFCKeditor->Height = $height;

			return $oFCKeditor->CreateHtml();
		}

		//TODO - altele
	}
