<?php

	class EmailSystem
	{
		protected $mail, $smarty;
		
		/* Constructor */
		public function __construct($email, $name = "")
		{
			$this->mail = new PHPMailer;
			$this->mail->IsHTML(true);
			$this->mail->From = 'office@company.ro';
			$this->mail->FromName = 'Business AA';
			$this->mail->AddAddress(trim($email), trim($name));
			
			$this->smarty = Application::getSmarty('/templates/', '/templates_c/');
		}
		
		// Recuperare parola
		public static function sendRecoveryPassword($email)
		{
			$user = new Users();
			$user->readField('email', $email);
			if (empty($user->id)) {
				return false;
			}
			
			$self = new self($user->email);
			$self->mail->Subject = 'Recuperare parola curs online';
			
			$self->smarty->assign('student', $user);
			
			$secu = new SecurityHash;
			$secu->generate($email);
			$self->smarty->assign('hash', $secu->hash);
			
			$self->mail->Body = $self->smarty->fetch('/mail/password_recovery.html');
			echo $self->mail->Body;die;
			//return $self->mail->Send();
		}
		
		
		
	}