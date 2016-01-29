<?php

	class Users  extends BaseObject
	{
		
		const
			SESSION_VAR = 'logged_user',
			MAIL_INVITATION = 2,
			MAIL_REMINDER_1 = 4,
			MAIL_REMINDER_2 = 8;

        public
            $id,
            $first_name,
            $last_name,
            $email,
            $telephone,
            $password,
            $isConfirmed,
            $isActive,
			$noOfCompanies,
			$isFree,
			$sw_user_id;
		
		public function getTableName()
		{
			return 'user';
		}
		
		public function getFields()
		{
			return array ('id', 'first_name', 'last_name', 'email', 'telephone', 'password', 'isConfirmed', 'isActive', 'noOfCompanies', 'isFree', 'sw_user_id');
		}
		
		public function canAddCompanies() {
			if(sizeof(Companies::getUserCompanies($this->id)) < $this->noOfCompanies ) {
				return true;
			} else {
				return false;
			}
		}
		
		public static function isLogged()
		{
			return (isset($_SESSION[self::SESSION_VAR]) && !empty($_SESSION[self::SESSION_VAR]));
		}
		
		public static function getLogged()
		{
			return self::isLogged() ? $_SESSION[self::SESSION_VAR] : false;
		}
		
		public static function setLogged($user)
		{
			DBLogging::addLog("login","logged-in", "", $user);
			$_SESSION[self::SESSION_VAR] = $user;
		}
		
		public static function logout()
		{
			DBLogging::addLog("login","logged-out", "", $_SESSION[self::SESSION_VAR]);
			unset($_SESSION[self::SESSION_VAR]);
		}
		
		public static function login($email, $pass)
		{
			$email = realEscapeString($email);
			$pass = md5($pass);

			$db = new DbMySql("SELECT `id` FROM `user` WHERE `email` = '{$email}' AND `password` = '{$pass}' and `isConfirmed`=1");

			if($db->nextRecord()) {
				self::setLogged(new self($db->f('id')));
				if ($res = self::getLogged()) {
                    if ( empty($res->last_login) ) {
                        $_SESSION['firstLoginFlag'] = true;
                    }
					$res->last_login = date("Y-m-d H:i:s");
					$res->update();
				}
			}
			
			return self::isLogged();
		}

        public static function register($post)
        {
            $user = new Users;
            $user->setRecord($post);
            $user->isConfirmed = 0;
            $user->isActive = 0;
			$user->isFree = 1;
            $user->password = md5($user->password);
            $user->insert();
			
			if($user->id) {
				//register the user in SW Admin and save the the SW_user_id
				$url = $GLOBALS['config']->sw_admin_url."/users/create";
				$myvars = 'user_id=' . $user->id;

				$ch = curl_init( $url );
				curl_setopt( $ch, CURLOPT_POST, 1);
				curl_setopt( $ch, CURLOPT_POSTFIELDS, $myvars);
				curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
				curl_setopt( $ch, CURLOPT_HEADER, 0);
				curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);

				$resp = curl_exec( $ch );
				$json = json_decode($resp, true);
				if(!empty($json['sw_user_id'])) {
					$user->sw_user_id = $json['sw_user_id'];
					$user->update();
				}
			}
        }
		
		public static function emailIsUnique($email) {
			$ret = array();
			$self = new self;
			$query = "	SELECT *							
						FROM `{$self->getTableName()}`
						WHERE email= '" . $email."'";
			
			$q = new DbMySql($query);
			$className = get_class($self);
			if ($q->nextRecord()) {
				return false;	
			}			
			return true;
		}
		
		public function getName()
		{
			return $this->first_name . ' ' . $this->last_name;
		}
		
		public function getList( $append = '' )
		{
			$ret = array();
			
			$query = "	SELECT *,
							(SELECT `confirmation_code` FROM `security_hash` WHERE `security_hash`.`email`=`user`.`email` LIMIT 1) AS `confirmation_code`
						FROM `{$this->getTableName()}`
					 " . $append;
			
			$q = new DbMySql($query);
			$className = get_class($this);
			while ($q->nextRecord()) {
				$obj = new $className;
				$obj->setRecord($q->getRecord());
				$obj->confirmation_code = $q->f('confirmation_code');
				$ret[$obj->id] = $obj;
			}
			
			return $ret;
		}
		
	}