<?php

#operating modes:
$config->maintenance_mode = false;
$config->debug_mode = false; #in functie de el, se afiseaza sau nu erorile; poate fi suprascris /per host


#default timezone:
$config->default_timezone = 'Europe/Bucharest'; //timpu local
#ATENTIE: asta afecteaza modul cum este apelata mktime, date, strtotime, etc !!!!!!!!!!


$config->project_name = 'Fintech Business Solutions'; 

#default meta tags:
$config->page_meta = new stdClass;
$config->page_meta->title = 'SilverWire';
$config->page_meta->description = '';
$config->page_meta->keywords = '';
$config->page_meta->language = 'RO';


#mailer:
$config->mail = new stdClass;
$config->mail->admin = 'asd@asd.asd';
$config->mail->contact = 'asd@asd.asd';
$config->mail->from_name = 'SilverWire';
$config->mail->from = 'mircearechi@gmail.com';
$config->mail->host = 'ssl://smtp.gmil.com';
$config->mail->default_charset = 'UTF-8';
$config->mail->content_type = 'text/html';
$config->mail->encoding = '8bit';
$config->mail->line_ending = "\n";


#auto include directories:
$config->auto_include_directories = array(
		'include/lib/classes', 
		'include/classes'
);

$config->version = '2.0';