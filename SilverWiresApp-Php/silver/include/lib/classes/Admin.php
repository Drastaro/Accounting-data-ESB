<?php

	/**
	 * Admin class.
	 */
	class Admin extends BaseObject
	{
		const 
			ACCESS_ADMINISTRATORS 	= 1,
			ACCESS_USERS			= 2,
			ACCESS_COMPANIES		= 4;
		
		public function getFields()
		{
			return array('id', 'email', 'password', 'name', 'access', 'active');
		}
		
		public function getTableName()
		{
			return 'admin';
		}


		/**
		 * Executa operatia de login pentru un username($email) si o parola($password).
		 * Daca operatia reuseste, adminul citit este salvat in sesiune si se returneaza true.
		 * Altfel returneaza false.
		 * 
		 * Se poate apela static.
		 *
		 * @param string $email
		 * @param string $password
		 * @return boolean
		 */
		public static function login($email, $password)
		{
			$email = realEscapeString($email);
			$md5Password = md5($password);

			$db = new DbMySql(" SELECT `id` FROM `admin` WHERE `email`='{$email}' AND `password`='{$md5Password}' ");
			
			if($db->nextRecord())
			{
				// exista user, password
				Admin::setLoggedUser(new Admin($db->f('id')));
			}
			
			return Admin::isLogged();
		}
		
		public function setRecord($record)
		{
			parent::setRecord($record);
		}
		
		public function hasAccess($accessVal)
		{
			return ($this->access & $accessVal);
		}
		
		public static function checkAccess($accessVal)
		{
			if (!self::isLogged()){
				die('No access');
			}
			
			$lu = self::getLogged();
			if (!($lu->access & $accessVal)){
				die('No access');
			}
			return true;
		}
		
		public static function getAccessData()
		{
			return array(
				self::ACCESS_ADMINISTRATORS	=> 'Administratori', 	// 1 << 0
				self::ACCESS_USERS		    => 'Clienți', 			// 1 << 1
				self::ACCESS_COMPANIES		=> 'Companii', 		    // 1 << 2
			);
		}
		
		public function hasAccessToPage($page)
		{
			$pages = array(
				'administrators' 	=> self::ACCESS_ADMINISTRATORS,
				'users'				=> self::ACCESS_USERS,
				'companies'			=> self::ACCESS_COMPANIES,

				//'ajax|delete_imagini'	=> self::ACCESS_COMENZI,
			);
			
			if (isset($pages[$page])){
				if ($this->hasAccess($pages[$page])){
					return true;
				}
				return false;
			}
			return true;
		}
		
		public static function checkPageAccess($page, $ajax = false)
		{
			$pageToChek = $page;
			if ($ajax){
				$pageToChek = 'ajax|' . $pageToChek; 
			}
			if (!self::getLogged()->hasAccessToPage($pageToChek)){
				if ($ajax){
					Ajax::outputError('No access');
				} else {
					die('No access');
				}
				exit();
			}
		}

		/**
		 * Returneaza true daca exista un admin logat curent.
		 *
		 * Se poate apela static.
		 *
		 * @return boolean
		 */
		public static function isLogged()
		{
			return !empty($_SESSION['user_admin']);
		}


		/**
		 * Returneaza adminul logat, daca exista unul.
		 * Se poate apela static.
		 *
		 * @return Admin
		 */
		public static function getLogged()
		{
			if(empty($_SESSION['user_admin'])) {
				return null;
			}

			return $_SESSION['user_admin'];
		}

		/**
		 * Folosit pentru a seta un admin ca fiind cel logat curent.
		 * Este apelata automat in functia login().
		 *
		 * Poate fi apelata pentru a re-actualiza modificarile facute unui admin, si
		 * a se reflecta si in sesiune.
		 *
		 * @param Admin $user
		 */
		public static function setLoggedUser($user)
		{
			$_SESSION['user_admin'] = $user;
		}

		/**
		 * Executa operatia de logout pentru adminul curent logat,
		 * daca exista unul.
		 *
		 */
		public static function logout()
		{
			unset($_SESSION['user_admin']);
		}
	}