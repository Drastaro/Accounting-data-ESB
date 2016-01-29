<?php

	class ePayment
	{
		var $MERCHANT = '';
		var $PASS = '';

		var $TESTORDER = false;

		var $ORDER_DATE;
		var $ORDER_REF = '';
		var $ORDER_PNAME = array();
		var $ORDER_PCODE = array();
		var $ORDER_PINFO = array();
		var $ORDER_PRICE = array();
		var $ORDER_QTY = array();
		var $ORDER_VAT = array();
		var $ORDER_VER = array();
		var $PRICES_CURRENCY = 'RON'; // RON | ROL | EUR | USD | GBP
		var $ORDER_SHIPPING = 0; // poate fi si '-1'
		var $DISCOUNT = 0;
		var $LANGUAGE = 'ro'; // |en
		var $PAY_METHOD = null; // CCVISAMC(default) |  CCAMEX |  CCDINERS |  CCJCB |  WIRE |  CASH

		var $BILL_FNAME;
		var $BILL_LNAME;
		var $BILL_CISERIAL;
		var $BILL_CINUMBER;
		var $BILL_CIISSUER;
		var $BILL_CNP;
		var $BILL_COMPANY;
		var $BILL_FISCALCODE;
		var $BILL_REGNUMBER;
		var $BILL_BANK;
		var $BILL_BANKACCOUNT;
		var $BILL_EMAIL;
		var $BILL_PHONE;
		var $BILL_FAX;
		var $BILL_ADDRESS;
		var $BILL_ADDRESS2;
		var $BILL_ZIPCODE;
		var $BILL_CITY;
		var $BILL_STATE;
		var $BILL_COUNTRYCODE;
		var $DELIVERY_FNAME;
		var $DELIVERY_LNAME;
		var $DELIVERY_COMPANY;
		var $DELIVERY_PHONE;
		var $DELIVERY_ADDRESS;
		var $DELIVERY_ADDRESS2;
		var $DELIVERY_ZIPCODE;
		var $DELIVERY_CITY;
		var $DELIVERY_STATE;
		var $DELIVERY_COUNTRYCODE;
		var $DESTINATION_CITY;
		var $DESTINATION_STATE;
		var $DESTINATION_COUNTRY;

		var $form_action = 'https://secure.epayment.ro/order/lu.php';
		var $form_name = 'epayment_form';
		var $form_auto_submit = true;
		var $form_input_image = '/images/epayment.jpg';
		var $form_input_text = 'ePayment';
		var $form_input_class = '';
		var $form_xhtml = false;


		function ePayment($merchant, $pass)
		{
			$this->MERCHANT = $merchant;
			$this->PASS = $pass;

			$this->ORDER_DATE = date("Y-m-d G:i:s"); // date("Y-m-d H:i:s");
		}

		function addProduct($code, $name, $qty, $price_no_vat, $vat = '19', $info = null, $ver = null)
		{
			$this->ORDER_PNAME[] = $name;
			$this->ORDER_PCODE[] = $code;
			$this->ORDER_PRICE[] = $price;
			$this->ORDER_QTY[] = $qty;
			$this->ORDER_VAT[] = $vat;

			// optional:
			if(!is_null($info)) {
				$this->ORDER_PINFO[] = $info;
			}

			if(!is_null($ver)) {
				$this->ORDER_VER[] = $ver;
			}
		}

		function getHtmlForm()
		{
			if($this->form_xhtml) {
				$short_tag_closer = ' />';

				$js_start_script = "\n/* <![CDATA[ */\n";
				$js_end_script = "\n/* ]]> */\n";
			} else {
				$short_tag_closer = '>';

				$js_start_script = '';
				$js_end_script = '';
			}

			#form:
			$html = '<form action="' . $this->form_action . '" method="post"';
			if($this->form_name) {
				$html .= ' name="' . $this->form_name . '" id="' . $this->form_name . '"';
			}

			$html .= '>';

			#the fields:
			$html .= empty($this->MERCHANT) ? "<!-- ERROR: MERCHANT is missing. -->" : $this->_createField('MERCHANT');
			$html .= empty($this->ORDER_REF) ? "<!-- NOTICE: ORDER_REF is missing. -->" : $this->_createField('ORDER_REF');
			$html .= empty($this->ORDER_DATE) ? "<!-- ERROR: ORDER_DATE is missing. -->" : $this->_createField('ORDER_DATE');
			$html .= empty($this->ORDER_PNAME) ? "<!-- ERROR: ORDER_PNAME is missing. -->" : $this->_createField('ORDER_PNAME');
			$html .= empty($this->ORDER_PCODE) ? "<!-- ERROR: ORDER_PCODE is missing. -->" : $this->_createField('ORDER_PCODE');
			$html .= empty($this->ORDER_PINFO) ? "<!-- NOTICE: ORDER_PINFO is missing. -->" : $this->_createField('ORDER_PINFO');
			$html .= empty($this->ORDER_PRICE) ? "<!-- ERROR: ORDER_PRICE is missing. -->" : $this->_createField('ORDER_PRICE');
			$html .= empty($this->ORDER_QTY) ? "<!-- ERROR: ORDER_QTY is missing. -->" : $this->_createField('ORDER_QTY');
			$html .= empty($this->ORDER_VAT) ? "<!-- ERROR: ORDER_VAT is missing. -->" : $this->_createField('ORDER_VAT');
			$html .= empty($this->ORDER_VER) ? "<!-- NOTICE: ORDER_VER is missing. -->" : $this->_createField('ORDER_VER');

			$html .= (is_numeric($this->ORDER_SHIPPING) && $this->ORDER_SHIPPING >= 0) ? 
						$this->_createField('ORDER_SHIPPING') : 
						"<!-- ERROR: ORDER_SHIPPING is missing. -->";
			$html .= empty($this->PRICES_CURRENCY) ?
						"<!-- NOTICE: PRICES_CURRENCY is missing. -->" :
						$this->_createField('PRICES_CURRENCY');
			$html .= (is_numeric($this->DISCOUNT) && $this->DISCOUNT >= 0) ?
						$this->_createField('DISCOUNT') :
						"<!-- NOTICE: DISCOUNT is missing or is invalid. -->";

			$html .= empty($this->DESTINATION_CITY) ?
						"<!-- NOTICE: DESTINATION_CITY is missing. -->" :
						$this->_createField('DESTINATION_CITY');
			$html .= empty($this->DESTINATION_STATE) ?
						"<!-- NOTICE: DESTINATION_STATE is missing. -->" :
						$this->_createField('DESTINATION_STATE');
			$html .= empty($this->DESTINATION_COUNTRY) ?
						"<!-- NOTICE: DESTINATION_COUNTRY is missing. -->" :
						$this->_createField('DESTINATION_COUNTRY');

			$html .= empty($this->PAY_METHOD) ? "<!-- NOTICE: PAY_METHOD is missing. -->" : $this->_createField('PAY_METHOD');

			#adaugam hash-ul de control:
			$html .= "\n<input type=\"hidden\" name=\"ORDER_HASH\" value=\"" . $this->_getOrderHash() . '"' . $short_tag_closer;

			#daca e tranzactie de test, specificam asta in formular:
			$html .= empty($this->TESTORDER) ? 
					"<!-- This is live transaction. -->" : 
					"\n<input type=\"hidden\" name=\"TESTORDER\" value=\"TRUE\"" . $short_tag_closer;

			#adaugam fieldurile optionale (care nu intra in hash, chiar daca sunt specificate):
			$optionalFields = $this->_getOptionalFields();
			foreach($optionalFields as $field_name) {
				if(empty($this->$field_name)) {
					continue;
				}

				$html .= $this->_createField($field_name);
			}

			#submit button:
			$button = '';
			if($this->form_input_image) {
				$button = "\n" . '<input type="image" value="" src="' . $this->form_input_image . '" alt="' . $this->form_input_text . '"';
			} else {
				$button = '<input type="submit" value="' . $this->form_input_text . '"';
			}

			if($this->form_input_class) {
				$button .= ' class="' . $this->form_input_class . '"';
			}

			$button .= $short_tag_closer;

			if($this->form_auto_submit) {
				$button = '<noscript>' . $button . '</noscript>';
			}

			#add the button:
			$html .= $button;

			#close form:
			$html .= "\n</form>";

			#add auto-submit:
			if($this->form_auto_submit) {
				if($this->form_name) {
					$html .= '<script type="text/javascript">' . 
								$js_start_script . 
								'document.' . $this->form_name . '.submit()' . 
								$js_end_script . 
							'</script>';
				} else {
					$html .= '<script type="text/javascript">' . 
								$js_start_script . 
								'document.forms[0].submit()' . 
								$js_end_script . 
							'</script>';
					// varianta asta nu va functiona intotdeauna,
					// da teoretic daca sunt si alte formulare in pagina, NU se foloseste auto-submit...deci e ok
				}
			}

			#returnam:
			return $html;
		}

		function _createField($name)
		{
			$name = strtoupper($name);
			$value = $this->$name;

			$short_tag_closer = $this->form_xhtml ? ' />' : '>';

			if(is_scalar($value)) {
				$ret = '<input type="hidden" name="' . $name . '" value="' . htmlspecialchars($value) . '"' . $short_tag_closer;
			} else if(is_array($value)) {
				$ret = '';
				foreach($value as $val) {
					$ret .= '<input type="hidden" name="' . $name . '[]" value="' . htmlspecialchars($val) . '"' . $short_tag_closer;
				}
			} else if(is_object($value)) {
				$ret = '';
				$value = get_object_vars($value);
				foreach($value as $val) {
					$ret .= '<input type="hidden" name="' . $name . '[]" value="' . htmlspecialchars($val) . '"' . $short_tag_closer;
				}
			}

			return "\n" . $ret;
		}

		function _getOrderHash()
		{
			$retval  = '';

			$retval .= $this->_encodeString($this->MERCHANT);
			$retval .= $this->_encodeString($this->ORDER_REF);
			$retval .= $this->_encodeString($this->ORDER_DATE);
			$retval .= $this->_encodeArray($this->ORDER_PNAME);
			$retval .= $this->_encodeArray($this->ORDER_PCODE);

			if(!empty($this->ORDER_PINFO)) {
				$retval .= $this->_encodeArray($this->ORDER_PINFO);
			}

			$retval .= $this->_encodeArray($this->ORDER_PRICE);
			$retval .= $this->_encodeArray($this->ORDER_QTY);
			$retval .= $this->_encodeArray($this->ORDER_VAT);

			if(!empty($this->ORDER_VER)) {
				$retval .= $this->_encodeArray($this->ORDER_VER);
			}

			if (is_numeric($this->ORDER_SHIPPING) && $this->ORDER_SHIPPING >= 0) {
				$retval .= $this->_encodeString($this->ORDER_SHIPPING);
			}

			if (!empty($this->PRICES_CURRENCY)) {
				$retval .= $this->_encodeString($this->PRICES_CURRENCY);
			}

			if (is_numeric($this->DISCOUNT) && $this->DISCOUNT >= 0) {
				$retval .= $this->_encodeString($this->DISCOUNT);
			}

			if (!empty($this->DESTINATION_CITY)) {
				$retval .= $this->_encodeString($this->DESTINATION_CITY);
			}

			if (!empty($this->DESTINATION_STATE)) {
				$retval .= $this->_encodeString($this->DESTINATION_STATE);
			}

			if (!empty($this->DESTINATION_COUNTRY)) {
				$retval .= $this->_encodeString($this->DESTINATION_COUNTRY);
			}

			if (!empty($this->PAY_METHOD)) {
				$retval .= $this->_encodeString($this->PAY_METHOD);
			}

			return $this->_hmac($retval);
		}

		function _hmac($data)
		{
			$key = $this->PASS;

			$b = 64; // byte length for md5
			if (strlen($key) > $b) {
			   $key = pack("H*", md5($key));
			}

			$key  = str_pad($key, $b, chr(0x00));
			$ipad = str_pad('', $b, chr(0x36));
			$opad = str_pad('', $b, chr(0x5c));
			$k_ipad = $key ^ $ipad ;
			$k_opad = $key ^ $opad;

			return md5($k_opad  . pack("H*", md5($k_ipad . $data)));
		}

		function _encodeObject($object)
		{
			$obj_array = get_object_vars($object);

			return $this->_encodeArray($obj_array);
		}

		function _encodeArray($array)
		{
			$retval = '';

			foreach($array as $element){
				$retval	.= $this->_encodeString($element);
			}

			return $retval;
		}

		function _encodeString($str)
		{
			return strlen($str) . $str;
		}

		function ipnHandler($post = null)
		{
			if(is_null($post)) { // compatibility
				$post = $_POST;
			}

			$result	= '';
			foreach($post as $key => $val) {
				if($key == "HASH"){
					continue;
				}

				if(is_array($val)) {
					$result .= $this->_encodeArray($val);
				} else if(is_object($val)) {
					$result .= $this->_encodeObject($val);
				} else if(is_scalar($val)) {
					$result	.= $this->_encodeString(stripslashes($val));
				}
			}

			if($this->_hmac($result) == $post["HASH"]){

				$date_return = date("YmdGis"); // date("YmdHis")

				// nu ar trebui facut pt. toate ? (in afara de cele cu indicele 0)
				$return  = $this->_encodeString($post['IPN_PID'][0]);
				$return .= $this->_encodeString($post['IPN_PNAME'][0]);
				$return .= $this->_encodeString($post['IPN_DATE']);
				$return .= $this->_encodeString($date_return);

				echo 'Verified OK!<EPAYMENT>' , $date_return , '|' , $this->_hmac($return) , '</EPAYMENT>';

			    //success:
				return true;
			}

			//failure:
			return false;
		}

		function _getOptionalFields()
		{
			return array(
				'BILL_FNAME',
				'BILL_LNAME',
				'BILL_CISERIAL',
				'BILL_CINUMBER',
				'BILL_CIISSUER',
				'BILL_CNP',
				'BILL_COMPANY',
				'BILL_FISCALCODE',
				'BILL_REGNUMBER',
				'BILL_BANK',
				'BILL_BANKACCOUNT',
				'BILL_EMAIL',
				'BILL_PHONE',
				'BILL_FAX',
				'BILL_ADDRESS',
				'BILL_ADDRESS2',
				'BILL_ZIPCODE',
				'BILL_CITY',
				'BILL_STATE',
				'BILL_COUNTRYCODE',
				'DELIVERY_FNAME',
				'DELIVERY_LNAME',
				'DELIVERY_COMPANY',
				'DELIVERY_PHONE',
				'DELIVERY_ADDRESS',
				'DELIVERY_ADDRESS2',
				'DELIVERY_ZIPCODE',
				'DELIVERY_CITY',
				'DELIVERY_STATE',
				'DELIVERY_COUNTRYCODE',
				'LANGUAGE'
			);
		}
	}
