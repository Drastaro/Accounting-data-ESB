<?php

	class Messages 
	{	
		public static function getMessages()
		{
			$errors = @$_SESSION['messages']['errors'];
			$notices = @$_SESSION['messages']['notices'];
			unset($_SESSION['messages']);
			
			$ret = '';
			
			if (!empty($errors) && count($errors) > 0){
				foreach ($errors as $value){
					$ret .= '<strong>Error !</strong>&nbsp;&nbsp;' . $value ;
				}
			}
			
			if (!empty($notices) && count($notices) > 0){
				foreach ($notices as $value){
					$ret .= '<strong>Success!</strong>&nbsp;&nbsp;' . $value ;
				}
			}
			return $ret;
		}
		
		public static function areMessages()
		{
			return !empty($_SESSION['messages']);
		}
		
		public static function areErrors()
		{
			return !empty($_SESSION['messages']['errors']);
		}
		
		public static function areNotices()
		{
			return !empty($_SESSION['messages']['notices']);
		}
		
		public static function deleteErrors()
		{
			unset($_SESSION['messages']['errors']);
		}
		
		public static function deleteNotices()
		{
			unset($_SESSION['messages']['notices']);
		}
		
		public static function deleteMessages()
		{
			unset($_SESSION['messages']);
		}
		
		public static function addNotice($message)
		{
			$_SESSION['messages']['notices'][] = $message;
		}
		
		public static function addError($message)
		{
			if (is_array($message)){
				foreach ($message as $value){
					$_SESSION['messages']['errors'][] = $value;
				}
			} else {
				$_SESSION['messages']['errors'][] = $message;
			}
		}
		
	}