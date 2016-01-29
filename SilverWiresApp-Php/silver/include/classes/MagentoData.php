<?php

	class MagentoData extends BaseObject
	{
        public
            $id,
            $user_id,
            $username,
			$pass,
			$url;
		
		public function getTableName()
		{
			return 'magento_data';
		}
		
		public function getFields()
		{
			return array ( 'id', 'user_id', 'username', 'pass', 'url' );
		}

       private function getList($append)
    {

        $ret = array();
        $fields = "`{$this->getTableName()}`.`" . implode("`, `{$this->getTableName()}`.`", $this->getFields()). "`";

        $query =  " SELECT $fields FROM " . $this->getTableName(). " " . $append;

		//echo $query;
		
        $q = new DbMySql($query, $this->getDatabase());
        $className = get_class($this);
        while ($q->nextRecord()) {
            $obj = new $className;
            $obj->setRecord($q->getRecord());
            $ret[$obj->id] = $obj;
        }

        return $ret;
    }
	
	
		
		
		
		

        public static function getMagentoDataByUserId($user)
        {
            $self = new self;
			
			//get data from SilverWireAdmin
			$url = $GLOBALS['config']->sw_admin_url."/magento/auth/get";
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
				$self = new MagentoData();
				$self->username=$json['magentoUsername'];
				$self->pass=$json['magentoPass'];
				$self->url=$json['magentoURL'];
			}
			
            return $self;
        }
		
		
		
		
        public static function saveData($post, $user)
        {
            if (!empty($post['mag_username']) &&!empty($post['mag_pass']) &&!empty($post['mag_url'])) {
                
				//send data to SilverWire Admin and store there
				$url = $GLOBALS['config']->sw_admin_url."/magento/auth/save";
				$myvars = 'sw_user_id=' . $user->sw_user_id;
				$myvars = $myvars. '&mag_username=' . $post['mag_username'];
				$myvars = $myvars. '&mag_pass=' . $post['mag_pass'];
				$myvars = $myvars. '&mag_url=' . $post['mag_url'];

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
					Messages::addNotice("Magento data was saved.");
					return true;
                } else {
					Messages::addError("Error on saving Magento data");
					return false;
				}
			}
            
			Messages::addError("Error on saving Magento data. All fields are mandatory.");
            return false;
        }
		
		
		

	}