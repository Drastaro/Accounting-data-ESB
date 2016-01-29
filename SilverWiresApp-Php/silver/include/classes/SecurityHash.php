<?php

	class SecurityHash extends BaseObject
	{
		const
			TYPE_SIGNUP = 'signup',
			TYPE_RECOVERY = 'recovery';

        public
            $id,
            $hash,
            $confirmation_code,
            $email,
            $date,
            $type;
		
		public function getTableName()
		{
			return 'security_hash';
		}
		
		public function getFields()
		{
			return array('id', 'hash', 'confirmation_code', 'email', 'date', 'type');
		}
		
		public function generate($email, $type = self::TYPE_RECOVERY)
		{
			$old = $this->getAll(" WHERE `email`='" . realEscapeString($email) . "' AND `type`='{$type}' ");
			if (count($old))
			{
				$old = array_values($old);
				$this->readId($old[0]->id);
				$this->date = date('Y-m-d H:i:s');
				$this->update();
			}
			else
			{
				$this->email = $email;
				$this->date = date('Y-m-d H:i:s');
				$this->type = $type;
				if ($type == self::TYPE_SIGNUP) {
					$this->confirmation_code = generateHash(6);
				}
				$this->insert();
				
				usleep(1);
				$this->hash = generateUniqueHash('e', $this->id);
				$this->update(); 
			}
		}
		
		public function isRecovery () {
			return (bool) ($this->type == self::TYPE_RECOVERY);
		}
		
		public function isSignup () {
			return (bool) ($this->type == self::TYPE_SIGNUP);
		}
		
		public function isValid () {
			if (empty($this->id) || empty($this->date)) {
				return false;
			}
			
			if ($this->type == self::TYPE_SIGNUP) {
				return (bool) ( 30 >= ((time() - strtotime($this->date)) / (3600 * 24)) );
				
			} else {
				return (bool) (24 >= ((time() - strtotime($this->date)) / 3600) );
			}
		}
		
	}