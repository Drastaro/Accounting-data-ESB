<?php

	class QuickBooksData extends BaseObject
	{
        public
            $id,
            $user_id,
            $username,
			$pass,
			$url;
		
		

       public static function getQuickbooksAuthStatus($user)
        {
            $self = new self;
			
			//get data from SilverWireAdmin
			$url = $GLOBALS['config']->sw_admin_url."/quickbooks/auth/status";
			$myvars = 'sw_user_id=' . $user->sw_user_id;

			$ch = curl_init( $url );
			curl_setopt( $ch, CURLOPT_POST, 1);
			curl_setopt( $ch, CURLOPT_POSTFIELDS, $myvars);
			curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
			curl_setopt( $ch, CURLOPT_HEADER, 0);
			curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);

			$resp = curl_exec( $ch );
			if($resp!=null) {
				$json = json_decode($resp, true);
				return $json;
			}
			
            return "";
        }
		
		public static function getQuickbooksSettings($user)
        {
            $self = new self;
			
			//get data from SilverWireAdmin
			$url = $GLOBALS['config']->sw_admin_url."/quickbooks/settings/get";
			$myvars = 'sw_user_id=' . $user->sw_user_id;

			$ch = curl_init( $url );
			curl_setopt( $ch, CURLOPT_POST, 1);
			curl_setopt( $ch, CURLOPT_POSTFIELDS, $myvars);
			curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
			curl_setopt( $ch, CURLOPT_HEADER, 0);
			curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);

			$resp = curl_exec( $ch );
			if($resp!=null) {
				$json = json_decode($resp, true);
				return $json;
			}
			
            return '';
        }
		
	
        public static function saveQuickbooksSettings($post, $user)
        {
            if (!empty($post['incomeAccount'])) {
                
				//send data to SilverWire Admin and store there
				$url = $GLOBALS['config']->sw_admin_url."/quickbooks/settings/save";
				/*$myvars = 'sw_user_id=' . $user->sw_user_id;
				$myvars = $myvars. '&incomeAccount=' . $post['incomeAccount'];
				$myvars = $myvars. '&taxes=' . $post['taxes'];
				*/
				
				$fields = array(
					'sw_user_id' => $user->sw_user_id,
					'incomeAccount' => $post['incomeAccount'],
					'taxes' => $post['taxes']
				);
				//url-ify the data for the POST
				$field_string = http_build_query($fields);
				echo $field_string;
				

				$ch = curl_init( $url );
				curl_setopt( $ch, CURLOPT_POST, 1);
				curl_setopt( $ch, CURLOPT_POSTFIELDS, $field_string);
				curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
				curl_setopt( $ch, CURLOPT_HEADER, 0);
				curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);

				$resp = curl_exec( $ch );
				var_dump($resp);
				echo "REST===".$resp;
				$json= null;
				if($resp!=null) {
					$json = json_decode($resp, true);
					echo "JSON==".$json;
				}
				
				if($json!=null &&  $json['result']=='true') {
					Messages::addNotice("QuickBooks settings were saved.");
					return true;
                } else {
					Messages::addError("Error on saving QuickBooks settings");
					return false;
				}
			}
            
			Messages::addError("Error on saving QuickBooks settings. All fields are mandatory.");
            return false;
        }
		
		public static function disconnectQuickbooks($post, $user)
        {
           // if (!empty($post['incomeAccount'])) {
                
				//send data to SilverWire Admin and store there
				$url = $GLOBALS['config']->sw_admin_url."/quickbooks/auth/disconnect";
				$myvars = 'sw_user_id=' . $user->sw_user_id;

				$ch = curl_init( $url );
				curl_setopt( $ch, CURLOPT_POST, 1);
				curl_setopt( $ch, CURLOPT_POSTFIELDS, $myvars);
				curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
				curl_setopt( $ch, CURLOPT_HEADER, 0);
				curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);

				$resp = curl_exec( $ch );
				$json= null;
				if($resp!=null) {
					$json = json_decode($resp, true);
				}
				
				if($json!=null &&  $json['result']=='true') {
					Messages::addNotice("QuickBooks connection with SilverWire app was stopped.");
					return true;
                } else {
					Messages::addError("Error on saving disconnecting QuickBooks.");
					return false;
				}
			//}
            
		//	Messages::addError("Error on saving QuickBooks settings. All fields are mandatory.");
          //  return false;
        }
		
		
		
		
		

	}