<?php
	
	ini_set("memory_limit", "100M");

	$action = !empty($_GET['action']) ? strtolower($_GET['action']) : '';
	$id = !empty($_GET['id']) ? $_GET['id'] : '';

	if (empty($id) || empty($action)) {
		header("HTTP/1.1 404 Not Found");
		echo 'no image'; die();
	}
	
	if (empty($_GET['w'])) {
		$_GET['w'] = 100;
	}
	if (empty($_GET['h'])) {
		$_GET['h'] = 60;
	}
	
	$resizes = array(
		/*
		'resize'	=> array(
							'width'			=> $_GET['w'],
							'height'		=> $_GET['h'],
							'resize_tip'	=> 'resize',
							'filesPath'		=> '/img/'
							),
		'crop'	=> array(
							'width'			=> $_GET['w'],
							'height'		=> $_GET['h'],
							'resize_tip'	=> 'crop',
							'filesPath'		=> '/img/'
							),
		'max'	=> array(
							'width'			=> $_GET['w'],
							'height'		=> $_GET['h'],
							'resize_tip'	=> 'max',
							'filesPath'		=> '/img/'
							),
		'fill'	=> array(
							'width'			=> $_GET['w'],
							'height'		=> $_GET['h'],
							'resize_tip'	=> 'fill',
							'fillColor'		=> 'FFFFFF',
							'filesPath'		=> '/img/'
							),
		*/
		'product-list'	=> array(
							'width'			=> 140,
							'height'		=> 140,
							'resize_tip'	=> 'crop',
							'filesPath'		=> '/img/products/'
							),
		'product-details'=> array(
							'width'			=> 225,
							'height'		=> 225,
							'resize_tip'	=> 'fill',
							'fillColor'		=> 'FFFFFF',
							'filesPath'		=> '/img/products/'
							),
		'session-thumb'	=> array(
							'width'			=> 180,
							'height'		=> 145,
							'resize_tip'	=> 'fill',
							'fillColor'		=> 'FFFFFF',
							'filesPath'		=> '/img/session/'
							),
		'session-large'	=> array(
							'width'			=> 800,
							'height'		=> 600,
							'resize_tip'	=> 'max',
							'filesPath'		=> '/img/session/'
							),
		'product-icon' => array(
							'width'			=> 57,
							'height'		=> 57,
							'resize_tip'	=> 'fill',
							'fillColor'		=> 'FFFFFF',
							'filesPath'		=> '/img/products/'
							),
	);
	
	
	$absolute = rtrim(str_replace('\\', '/', dirname(__FILE__)), '/');
	
	include($absolute . '/include/lib/classes/Image.php');
	
	if (!array_key_exists($action, $resizes)){
		
		switch ($action){
			
			default:
				header("HTTP/1.1 404 Not Found");
			exit();
			
	
		}
		
	} else {
		
		$resizeOptions = $resizes[$action];
		
		$fileFolder = $absolute . '/' . ltrim($resizeOptions['filesPath'], '/');
		$filePath = $fileFolder  . $id;
		$saveFolder = $absolute . '/img/_cache/';
		

		$validExt = array('jpg', 'gif', 'jpeg', 'png');
		foreach ($validExt as $exten){
			$tmpFilePath = $filePath . '.' . $exten;
			if (file_exists($tmpFilePath)){
				$filePath = $tmpFilePath;
				break;
			}
		}
		
		if (!file_exists($filePath)){
			$filePath = $filePath . '.jpg';
			if (!file_exists($filePath)){
				header("HTTP/1.1 404 Not Found");
				echo 'No image to resize';
				exit();
			}
		}
		
		if (!file_exists($saveFolder)){
			mkdir($saveFolder, 0777, true);
		}
		
		$saveFilePath = $saveFolder . $action . '_' . str_replace('/', '_', $id) . '.jpg';
		
		if (file_exists($saveFilePath)) {
			$ofTime = filemtime($filePath);
			$sfTime = filemtime($saveFilePath);
			
			if ($ofTime < $sfTime) {
				header('Content-Type: image/jpeg');
				header('Last-Modified: '. gmdate('D, d M Y H:i:s', $sfTime) . ' GMT');
				echo file_get_contents($saveFilePath);
				exit();
			}
			
		}
		
		$image = new Image($filePath);
		
		if (!$image->isValid()){
			echo 'Invalid image file';
			header("HTTP/1.1 404 Not Found");
			exit();
		}
		
		switch ($resizeOptions['resize_tip']){
			default:
			case 'resize':
				
				$image = $image->resize($resizeOptions['width'], $resizeOptions['height'], $saveFilePath);	
				
			break;
			
			case 'crop':
				
				$image = $image->resizeCrop($resizeOptions['width'], $resizeOptions['height'], $saveFilePath);
				
			break;
			
			case 'max':
				
				$image = $image->resizeMaxDimensions($resizeOptions['width'], $resizeOptions['height'], $saveFilePath);
				
			break;
			
			case 'fill':
				
				$image = $image->resizeWithBg($resizeOptions['width'], $resizeOptions['height'], $resizeOptions['fillColor'], $saveFilePath);
				
			break;
			
			case 'watermark':
				
				$image = $image->resizeCrop($resizeOptions['width'], $resizeOptions['height'], $saveFilePath);
				$bImage = new Image($absolute . '/img/promotie.png');
				$image->watermarkAlign($bImage, 'right', 'top', $saveFilePath);
				
			break;
			
		}
		
		@chmod($saveFilePath, 0777);
		$image->output();
		
		exit();	
	}