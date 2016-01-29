<?php

	#constante:
	define('VALID_NOT_EMPTY', 1);

	define('VALID_IN_ARRAY', 2);
	define('VALID_NOT_IN_ARRAY', 3);

	define('VALID_MATCH', 4);
	define('VALID_NOT_MATCH', 5);

	define('VALID_CUSTOM_FIELD', 6);
	define('VALID_NOT_CUSTOM_FIELD', 7);

	define('VALID_CONFIRM', 8);
	define('VALID_NOT_CONFIRM', 9);

	define('VALID_NAME', 10);
	define('VALID_ALPHA', 11);
	define('VALID_ALPHANUM', 12);

	define('VALID_PHONE', 13);
	define('VALID_ZIP', 14);
	define('VALID_CREDIT_CARD', 15);

	define('VALID_INT', 16);
	define('VALID_FLOAT', 17);
	define('VALID_NUMBER', 18);

	define('VALID_DATE', 19);

	define('VALID_IP', 20);
	define('VALID_URL', 21);
	define('VALID_EMAIL', 22);

	define('VALID_CAPTCHA', 23);

	define('VALID_FALSE', 24); // always invalid...
	define('VALID_TRUE', 25); // always valid...

	include_once LIB_PATH . "/classes/Valid.php";

	class InputValidator
	{
		var $input;
		var $errors;

		function InputValidator($array)
		{
			$this->setInputArray($array);
		}

		function setInputArray($array)
		{
			if(is_array($array)) {
				$this->input = $array;
			} else {
				trigger_error("{$array} is not an valid array.");
			}

			$this->resetErrors();
		}

		function getInputArray()
		{
			return $this->input;
		}

		function set($name, $type, $msg = '', $extra = null)
		{
			# testam daca exista erori anterioare pentru acest field; daca da, iesim:
			if(isset($this->errors[$name])) {
				return;
			}

			# in cazul confirmarilor, nu trebuie sa existe erori anterioare nici pentru fieldul pe care il confirma:
			if($type == VALID_CONFIRM || $type == VALID_NOT_CONFIRM) {
				if(isset($this->errors[$extra])) {
					return;
				}
			}

			# extragem valoarea pentru fieldul curent:
			$value = isset($this->input[$name]) ? $this->input[$name] : null;

			# validam corespunzator fieldul:
			$valid = false;
			switch ($type){
				case VALID_NOT_EMPTY:
					$valid = (bool)$value;
				break;

				case VALID_IN_ARRAY:
					$valid = in_array($value, $extra);
				break;

				case VALID_NOT_IN_ARRAY:
					$valid = !in_array($value, $extra);
				break;

				case VALID_MATCH:
					$valid = preg_match($extra, $value);
				break;

				case VALID_NOT_MATCH:
					$valid = !preg_match($extra, $value);
				break;

				case VALID_CUSTOM_FIELD:
					if(is_null($extra) || !is_callable($extra, true)) {
						trigger_error("Custom function is not defined: " . print_r($extra, true));
						break; //switch
					}

					$valid = call_user_func($extra, $value);
				break;

				case VALID_NOT_CUSTOM_FIELD:
					if(is_null($extra) || !is_callable($extra, true)) {
						trigger_error("Custom function is not defined: " . print_r($extra, true));
						break; //switch
					}

					$valid = !call_user_func($extra, $value);
				break;

				case VALID_CONFIRM:
					$valid = ($value == $this->input[$extra]);
				break;

				case VALID_NOT_CONFIRM:
					$valid = ($value != $this->input[$extra]);
				break;

				case VALID_NAME:
					$valid = $value && preg_match("/^[a-zA-Z\-\.,'\s]{1,40}$/", $value);
				break;

				case VALID_ALPHA:
					$valid = $value && preg_match("/^[a-zA-Z]*$/", $value);
				break;

				case VALID_ALPHANUM:
					$valid = $value && preg_match("/^[a-zA-Z0-9]*$/", $value);
				break;

				case VALID_DATE:
					$valid = Valid::date($value);
				break;

				case VALID_INT:
					//$valid = ($value !== '') && ((int)$value == $value);
					$valid = ctype_digit($value);
				break;

				case VALID_FLOAT:
					#$valid = ($value !== '') && ((float)$value == $value);
					$valid = preg_match("/^[.0-9]+$/", $value);
				break;

				case VALID_NUMBER:
					$valid = Valid::number($value);
				break;

				case VALID_EMAIL:
					$extra = is_null($extra) ? false : $extra;

					$valid = Valid::email($value, $extra);
				break;

				case VALID_URL:
					$valid = Valid::uri($value);
				break;

				case VALID_PHONE:
					$extra = is_null($extra) ? true : $extra;

					$valid = Valid::phoneNumber($value, $extra);
				break;

				case VALID_ZIP:
					$valid = Valid::postalCode($value);
				break;

				case VALID_CREDIT_CARD:
					$valid = Valid::creditCard($value, $extra);
				break;

				case VALID_IP:
					$valid = Valid::ip($value);
				break;

				case VALID_CAPTCHA:
					include_once LIB_PATH . "/classes/Captcha.php";

					$valid = Valid::captcha($name, $value);
				break;

				case VALID_FALSE:
					$valid = false;
				break;

				case VALID_TRUE:
					$valid = true;
				break;

				default:
					trigger_error("Validation type is invalid: '{$type}'.");
				break;
			}

			# setam eroarea, daca validarea este incorecta:
			if(!$valid) {
				$this->errors[$name] = $msg;
			}
		}

		function setOptional($name, $type, $msg = '', $extra = null)
		{
			if (empty($this->input[$name])) {
				return;
			}

			$this->set($name, $type, $msg, $extra);
		}

		function getErrors()
		{
			return $this->errors;
		}

		function hasErrors()
		{
			return !empty($this->errors);
		}

		function getFirstError()
		{
			if($this->hasErrors()) {
				$msg = reset($this->errors);
				$field = key($this->errors);

				return array($field => $msg);
			}

			return null;
		}

		function getFirstErrorMessage()
		{
			if($this->hasErrors()) {
				return reset($this->errors);
			}

			return '';
		}

		function getFirstErrorField()
		{
			if($this->hasErrors()) {
				reset($this->errors);
				return key($this->errors);
			}

			return '';
		}

		function resetErrors()
		{
			$this->errors = array();
		}
	}
