<?php

	/**
	 * Image class.
	 *
	 * Author: Jumpeye Creative Media
	 *
	 * (C) Copyright 2005 Jumpeye Creative Media http://www.jumpeye.com. All rights reserved.
	 *                    
	 */

	define('ALIGN_LEFT', 'left');
	define('ALIGN_CENTER', 'center');
	define('ALIGN_RIGHT', 'right');
	define('VALIGN_TOP', 'top');
	define('VALIGN_CENTER', 'center');
	define('VALIGN_BOTTOM', 'bottom');

	class Image
	{
		var $resource;

		/**
		 * Constructor
		 *
		 * @param object sau string $source - resursa de tip imagine sau calea spre o imagine
		 * @return Image
		 */
		function Image($source = null)
		{
			if(!$this->gd_version()) {
				Application::fatalError("The server does not support image operations.");
				return;
			}

			if(is_resource($source)) {
				$this->resource = $source;
			} else if(file_exists($source)) {

				#testam sa fie imagine:
				$fileinfo = @getimagesize($source);
				if($fileinfo === false) {
					return;
				}

				#testam mime type-ul (sa nu fie psd sau swf sau whatever)
				$mime = @$fileinfo['mime'];
				if(!in_array($mime, $this->getAllowedMimeTypes())) {
					return;
				}

				switch ($mime) {
					case 'image/pjpeg':
					case 'image/jpeg':
					case 'image/jpg':
						$this->resource = imagecreatefromjpeg($source);
						break;

					case 'image/gif':
						$this->resource = imagecreatefromgif($source);
						break;

					case 'image/x-png':	
					case 'image/png':
						$this->resource = imagecreatefrompng($source);
						break;

					default:
						return;
				}
			}
		}

		function gd_version()
		{
			static $gd_version = null;

			if ($gd_version === null) {
				if (function_exists('gd_info')) {
					$gd = gd_info();
					$gd = $gd["GD Version"];
					$regex = "/([\d\.]+)/i";
				} else {
					ob_start();
					phpinfo(8);
					$gd = ob_get_contents();
					ob_end_clean();
					$regex = "/\bgd\s+version\b[^\d\n\r]+?([\d\.]+)/i";
				}

				if (preg_match($regex, $gd, $m)) {
					$gd_version = (float) $m[1];
				} else {
					$gd_version = 0;
				}
			}

			return $gd_version;
		} 

		/**
		 * Creaza un nou obiect de tip Image
		 *
		 * @param int $width - width poza
		 * @param int $height - height poza
		 * @param boolean $truecolor - default true
		 * @return object Image
		 */
		function create($width, $height, $truecolor = true)
		{
			if ($truecolor) {
				$resource = imagecreatetruecolor($width, $height);
			}else {
				$resource = imagecreate($width, $height);
			}

			return new Image($resource);
		}

		/**
		 * Distruge imaginea curenta
		 *
		 * @return unknown
		 */
		function destroy() 
		{
			if($this->isValid()) {
				return imagedestroy($this->resource);
			}

			return false;
		}

		/**
		 * returneaza array cu mime type alowed
		 *
		 * @return array
		 */
		function getAllowedMimeTypes()
		{
			return array('image/pjpeg', 'image/jpeg', 'image/jpg', 'image/x-png', 'image/png', 'image/gif');
		}

		/**
		 * Returneaza resursa imagini.
		 *
		 * @return resource id
		 */
		function getResource()
		{
			return $this->resource;
		}

		/**
		 * Verifica daca resursa este de tip imagine
		 *
		 * @return boolean
		 */
		function isValid()
		{
			return is_resource($this->resource) && strtolower(get_resource_type($this->resource)) == 'gd';
		}

		/**
		 * Verifica daca resursa este de tip truecolor
		 *
		 * @return boolean
		 */
		function isTrueColor()
		{
			return imageistruecolor($this->resource);
		}

		/**
		 * Salveaza imaginea din resursa in
		 * destinatia specificata.
		 *
		 * @param string $destination
		 * @return boolean
		 */
		function save($destination)
		{
			if (!$this->isValid()) {
				return false;
			}

			$ext = $this->_getfileExt($destination);
			switch ($ext){
				case 'jpeg':
				case 'jpg':
					return imagejpeg($this->resource, $destination, 90);

				case 'gif':
					return imagegif($this->resource, $destination);

				case 'png':
					return imagepng($this->resource, $destination);
				default:
					return false;
			}

			return true;
		}

		/**
		 * Face output la o imagine.
		 *
		 * @return image
		 */
		function output($type = 'jpg') 
		{
			if (!$this->isValid()) {
				return false;
			}

			if(headers_sent()) {
				return;
			}

			switch ($type) {
				case 'jpg':
				case 'jpeg':
					header('Content-Type: image/jpg');	
					return imagejpeg($this->resource);

				case 'gif':
					header('Content-Type: image/gif');
					return imagegif($this->resource);

				case 'png':
					header('Content-Type: image/png');
					return imagepng($this->resource);

				default:
					return;
			}
		}
		
		/**
		 * Face resize la o imagine la marimea specificata
		 * iar ce ramane in plus va fi taiat din imagine.
		 * 
		 * @param int $width
		 * @param int $height
		 * @return boolean
		 */
		function resizeCrop($maxWidth, $maxHeight, $destination = null)
		{
			if (!$this->isValid()) {
				return false;
			}

			$this_width = imagesx($this->resource);
			$this_height = imagesy($this->resource);

			$proportion = max($maxWidth / $this_width, $maxHeight / $this_height);

			$width = $this_width * $proportion;
			$height = $this_height * $proportion;

			$new_width = $this_width * $proportion;
			$new_height = $this_height * $proportion;

			$x = intval(($new_width - $maxWidth) / 2);
			$y = intval(($new_height - $maxHeight) / 2);

			$resized_img = $this->_resize($new_width, $new_height);
			if($resized_img === false) {
				return false;
			}

			$truecolor = is_null($destination) ? $this->isTrueColor() : $this->_isTrueColor($destination);
			$canvas = $this->create($maxWidth, $maxHeight, $truecolor);
			if($canvas === false) {
				return false;
			}
			
			if ($truecolor) {
				imagecopyresampled($canvas->resource, $resized_img->resource, 0, 0, $x, $y, $maxWidth, $maxHeight, $maxWidth, $maxHeight);
			} else {
				imagecopyresized($canvas->resource, $resized_img->resource, 0, 0, $x, $y, $maxWidth, $maxHeight, $maxWidth, $maxHeight);
			}

			if(!is_null($destination)) {
				$canvas->save($destination);
			}

			return $canvas;
		}

		/**
		 * Face resize la o imagine si ce ramane in plus
		 * umble cu culoarea specificata in functie.
		 * ex: $upload->resizeWithBg(200, 1000, 'AAFF00');
		 * @param int $width
		 * @param int $height
		 * @param string $bgcolor
		 * @return boolean
		 */
		function resizeWithBg($canvas_width, $canvas_height, $bgcolor = 'FFFFFF', $destination = null)
		{
			if (!$this->isValid()) {
				return false;
			}

			$truecolor = is_null($destination) ? $this->isTrueColor() : $this->_isTrueColor($destination);

			$canvas = Image::create($canvas_width, $canvas_height, $truecolor);
			if($canvas === false) {
				return false;
			}

			$canvas->fillBackground($bgcolor);

			$img = $this->resizeMaxDimensions($canvas_width, $canvas_height);
			if($img === false) {
				return false;
			}

			$dst_w = imagesx($img->resource);
			$dst_h = imagesy($img->resource);
			$x = ($canvas_width  - $dst_w) / 2;
			$y = ($canvas_height - $dst_h) / 2;

			return $canvas->watermarkAlign($img, ALIGN_CENTER, VALIGN_CENTER, $destination);
		}

		/**
		 * Suprapune o imagine peste imaginea curenta,
		 * in pozitia specificata(x,y), la dimensiunea specificata;
		 * daca destination e prezent, imaginea returnata e salvata in destinatie
		 *
		 * @param int $x
		 * @param int $y
		 * @param int $width
		 * @param int $height
		 * @return boolean
		 */

		function watermark($img, $x, $y, $width = null, $height = null, $destination = null)
		{
			if (!$this->isValid()) {
				return false;
			}

			if(!is_object($img) || !is_a($img, 'Image') || !$img->isValid()) {
				return false;
			}

			$truecolor = is_null($destination) ? $this->isTrueColor() : $this->_isTrueColor($destination);

			#daca nu e specificat, se ia dimensiunea originala a imaginii
			if(! (is_null($width) || is_null($height))) {
				$resized_img = $img->_resize($width, $height, $truecolor);

				if($resized_img === false) {
					$resized_img = $img;
				}
			} else {
				$width = imagesx($img->resource);
				$height = imagesy($img->resource);

				$resized_img = $img;
			}

			$ret = $this->cloneImage();
			imagecopy($ret->resource, $resized_img->resource, $x, $y, 0, 0, $width, $height);

			return $ret;
		}
		
		function watermarkAlign($img, $align_x = 'left', $align_y = 'top', $destination = null)
		{
			if (!$this->isValid()) {
				return false;
			}

			if(!is_object($img) || !is_a($img, 'Image') || !$img->isValid()) {
				return false;
			}

			$this_width = imagesx($this->resource);
			$this_height = imagesy($this->resource);

			$width = imagesx($img->resource);
			$height = imagesy($img->resource);

			$x = $y = 0;

			if($align_x == 'left') {
				$x = 0;
			} else if($align_x == 'center') {
				$x = ($this_width - $width) / 2;
			} else if($align_x == 'right') {
				$x = $this_width - $width;
			}

			if($align_y == 'top') {
				$y = 0;
			} else if($align_y == 'center') {
				$y = ($this_height - $height) / 2;
			} else if($align_y == 'bottom') {
				$y = $this_height - $height;
			}

			$ret = $this->cloneImage();
			if($ret === false) {
				return false;
			}

			imagecopy($ret->resource, $img->resource, $x, $y, 0, 0, $width, $height);

			if(!is_null($destination)) {
				$ret->save($destination);
			}

			return $ret;
		}
		
		/**
		 * Face resize in functie de dimensiunea maxima 
		 * pt latime si inaltime
		 *
		 * @param int $maxWidth
		 * @param int $maxHeight
		 * @return boolean
		 */
		function resizeMaxDimensions($maxWidth, $maxHeight, $destination = '')
		{
			if (!$this->isValid()) {
				return false;
			}

			$this_width = imagesx($this->resource);
			$this_height = imagesy($this->resource);

			$proportion = min($maxWidth / $this_width, $maxHeight / $this_height, 1);
			
			$width = $this_width * $proportion;
			$height = $this_height * $proportion;

			if (is_null($destination)) {
				$img = $this->_resize($width, $height, $this->isTrueColor());
			} else {
				$img = $this->_resize($width, $height, $this->_isTrueColor($destination));
				if($img !== false) {
					$img->save($destination);
				}
			}
			
			return $img;
		}

		/**
		 * Face resize proportional la o imagine.
		 * ex: $image->resizeProportional(60); // 60% din imagine
		 *
		 * @param int $proportion
		 * @return boolean
		 */
		function resizeProportional($proportion, $destination = '')
		{
			if (!$this->isValid()) {
				return false;
			}

			$this_width = imagesx($this->resource);
			$this_height = imagesy($this->resource);
			$width = intval(($this_width * $proportion) / 100);
			$height = intval(($this_height * $proportion) / 100);

			if (is_null($destination)) {
				$img = $this->_resize($width, $height, $this->isTrueColor());	
			} else {
				$img = $this->_resize($width, $height, $this->_isTrueColor($destination));
				if($img !== false) {
					$img->save($destination);
				}
			}

			return $img;
		}
		
		/**
		 * Face resize proportional la imagine in functie
		 * de inaltimea specificata
		 *
		 * @param int $height
		 * @return boolean
		 */
		function resizeByHeight($height, $destination = '')
		{
			$height = intval($height);

			if (!$this->isValid()) {
				return false;
			}

			$this_width = imagesx($this->resource);
			$this_height = imagesy($this->resource);
			$width = ($height / $this_height) * $this_width;

			if (is_null($destination)) {
				$img = $this->_resize($width, $height, $this->isTrueColor());	
			} else {
				$img = $this->_resize($width, $height, $this->_isTrueColor($destination));
				if($img !== false) {
					$img->save($destination);
				}
			}

			return $img;
		}
		
		/**
		 * Face resize proportional la imagine in functie
		 * de lungimea specificata
		 *
		 * @param int $width
		 * @return boolean
		 */
		function resizeByWidth($width, $destination = '')
		{
			$width = intval($width);

			if (!$this->isValid()) {
				return false;
			}

			$this_width = imagesx($this->resource);
			$this_height = imagesy($this->resource);
			$height = ($width / $this_width) * $this_height;

			if (is_null($destination)) {
				$img = $this->_resize($width, $height, $this->isTrueColor());	
			} else {
				$img = $this->_resize($width, $height, $this->_isTrueColor($destination));
				if($img !== false) {
					$img->save($destination);
				}
			}

			return $img;
		}
		
		/**
		 * Creeaza o imagine la marimea specificata, resize-uita.
		 * Imaginea este 'intinsa'.
		 *
		 * @param int $width
		 * @param int $height
		 * @return boolean
		 */
		function resize($width, $height, $destination = null) 
		{
			if (!$this->isValid()) {
				return false;
			}

			if (is_null($destination)) {
				$img = $this->_resize($width, $height, $this->isTrueColor());	
			} else {
				$img = $this->_resize($width, $height, $this->_isTrueColor($destination));
				if($img !== false) {
					$img->save($destination);
				}
			}

			return $img;
		}

		function cloneImage() 
		{
			$this_width = imagesx($this->resource);
			$this_height = imagesy($this->resource);
			$truecolor = $this->isTrueColor();

			return $this->_resize($this_width, $this_height, $truecolor);
		}

		function fillBackground($color = 'FFFFFF', $x = 0, $y = 0)
		{

			if (!$this->isValid()) {
				return false;
			}

			$color = $this->_parseColor($color);
			if($color === false) {
				$bg1 = $bg2 = $bg3 = 255;
			} else {
				list($bg1, $bg2, $bg3) = $color;
			}

			$x = intval($x);
			$y = intval($y);

			$col = imagecolorallocate($this->resource, $bg1, $bg2, $bg3);

			return imagefill($this->resource, $x, $y, $col);
		}

		function canBeResized($filePath)
		{
			#testam sa fie imagine:
			$fileinfo = @getimagesize($filePath);
			if($fileinfo === false) {
				return false;
			}

			#testam mime type-ul (sa nu fie psd sau swf sau whatever)
			$mime = @$fileinfo['mime'];
			if(!in_array($mime, Image::getAllowedMimeTypes())) {
				return false;
			}
			return true;
		}
		
		function _getfileExt($filename)
		{
			return strtolower(substr(strrchr($filename, '.'), 1));
		}

		function _isTrueColor($path)
		{
			$ext = $this->_getfileExt($path);
			if($ext == 'gif') {
				return false;
			}

			return true;
		}

		function _parseColor($color) 
		{
			$color = ltrim($color, '#');
			if (strlen($color) != 6) {
				return false;
			}

			$bg1 = hexdec(substr($color,0,2));
			$bg2 = hexdec(substr($color,2,2));
			$bg3 = hexdec(substr($color,4,2));

			return array($bg1, $bg2, $bg3);
		}

		function _resize($width, $height, $truecolor = true)
		{
			$img = Image::create($width, $height, $truecolor);
			$resource = $img->getResource();

			$this_width = imagesx($this->resource);
			$this_height = imagesy($this->resource);

			if($truecolor) {
				$success = imagecopyresampled($resource, $this->resource, 0, 0, 0, 0, $width, $height, $this_width, $this_height);
			} else {
				$success = imagecopyresized($resource, $this->resource, 0, 0, 0, 0, $width, $height, $this_width, $this_height);
			}

			if(!$success) {
				return false;
			}

			return $img;
		}
	}
