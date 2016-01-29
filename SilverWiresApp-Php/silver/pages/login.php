<?php

	if (Users::isLogged())
	{
		jump(Application::getMappedPath('/'));
	}

	if ($config->isPost() && !empty($_POST['mode'])) {
		switch ($_POST['mode'])
		{
			case 'login':
				if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) 
                {
                    Messages::addError('Acest email este invalid.');
					break;
                } else if(!Users::login($_POST['email'], $_POST['password']))
				{
					Messages::addError('The data entered is incorrect. Please try again.');
				}
				break;
					
			case 'recover':
				if (EmailSystem::sendRecoveryPassword($_POST['email'])) {
					Messages::addNotice('An email was sent to the specified addres with password reset instructions.');
				} else {
					Messages::addError('Password recovery has failed. Please contact us through e-mail: ' . "contact@fintech-solutions.ro");
				}
				break;

            case 'signup':
                if (empty($_POST['last_name']) || empty($_POST['first_name']) || empty($_POST['telephone'])
                    || empty($_POST['email']) || empty($_POST['password'])
                ) {
                    Messages::addError('All fields are mandatory.');
                }				
                else if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) 
                {
                    Messages::addError('This e-mail in invalid.');
                }
                else if ($_POST['password'] != $_POST['password_confirmation'])
                {
                    Messages::addError('Password confirmation is incorrect.');
                }
				else if (!Users::emailIsUnique($_POST['email']))
                {
                    Messages::addError('This email is already registered.');
                }
                else
                {
                    Users::register($_POST);
					Messages::addNotice('User was sucessfully registered. An activation email will be sent to your email address shortly.');
                    //Users::login($_POST['email'], $_POST['password']);
                }
			
                break;
				
		}
		jump(Application::getMappedPath('/'));
	
	}
	$smarty->assign('pageName', 'login-page');

	$smarty->assign('CONTENT', 'pages/login.tpl');
