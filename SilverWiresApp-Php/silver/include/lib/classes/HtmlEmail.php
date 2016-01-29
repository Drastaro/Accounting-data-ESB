<?php

	class HtmlEmail
	{
		var $From = 'nuraspunde@zoop.ro';
		var $FromName = 'Zoop';

		var $indexTemplate = 'index_email.tpl';
		var $content_tpl_var = 'EMAIL_CONTENT';

		var $inlineImages = array(
			'CID1' => 'images/email_header.jpg',
			'CID2' => 'images/email_content_top.gif',
			'CID3' => 'images/email_content_bottom.gif',
			'CID4' => 'images/email_footer_top.gif',
			'CID5' => 'images/email_footer_bottom.gif',
			'CID6' => 'images/bluebox_left.gif',
			'CID7' => 'images/bluebox_right.gif'
		);
		var $img_encoding = 'base64';
		var $use_remote_images = false;

		function send($to, $toName, $subject, $tpl, $tpl_vars = array())
		{
			global $config;

			$smarty = new Smarty;
			$smarty->template_dir = $config->absolute_path.'/'.$config->template_root_dir;
			$smarty->compile_dir = $config->absolute_path.'/'.$config->template_compile_dir;
			$smarty->compile_check = true;

			#setam variabilele in template:
			$smarty->assign($tpl_vars);

			$mailer = new PHPMailer;
			$mailer->isHtml(true);

			#atasam imaginile in template si in email:
			foreach($this->inlineImages as $tpl_var => $img_path) {

				if($this->use_remote_images) {
					$smarty->assign($tpl_var, $config->absolute_url . $img_path);
				} else {
					$absolute_path = $config->absolute_path . '/' .  $img_path;
					$cid = md5($absolute_path);
					$img_name = basename($absolute_path);

					$file_ext = strtolower(file_extension($img_name));
					if($file_ext == 'gif') {
						$content_type = 'image/gif';
					} else if($file_ext == 'png') {
						$content_type = 'image/png';
					} else if($file_ext == 'jpeg' || $file_ext == 'jpg') {
						$content_type = 'image/jpeg';
					} else {
						continue;
					}

					$mailer->AddEmbeddedImage($absolute_path, $cid, $img_name, $this->img_encoding, $content_type);

					$smarty->assign($tpl_var, "cid:{$cid}");
				}
			}

			#putenmsubiectul in titlul paginii:
			$smarty->assign('SUBJECT', $subject);

			#setam data curenta:
			$lunile =  get_months();
			$luna = $lunile[date("n")];
			$smarty->assign('data_curenta', date("d")  . ' ' . $luna . ' ' . date("Y"));

			#obtinem continutul final:
			$smarty->assign($this->content_tpl_var, $smarty->fetch($tpl));
			$content = $smarty->fetch($this->indexTemplate);

			$mailer->From = $this->From;
			$mailer->FromName = $this->FromName;
			$mailer->Subject = $subject;
			$mailer->AddAddress($to, $toName);
			$mailer->Body = $content;

			return $mailer->Send();
		}
	}
