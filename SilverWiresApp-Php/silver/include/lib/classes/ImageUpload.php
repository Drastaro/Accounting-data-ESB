<?php

	/**
	 * Upload class.
	 *
	 * Author: Jumpeye Creative Media
	 *
	 * (C) Copyright 2005 Jumpeye Creative Media http://www.jumpeye.com. All rights reserved.
	 *                    
	 */

	include_once LIB_PATH . "/classes/Image.php";

	class ImageUpload extends Upload 
	{
		var $imgMaximumWidth;
		var $imgMinimumWidth;
		var $imgMaximumHeight;
		var $imgMinimumHeight;

		function getImageMaximumWidth()
		{
			return $this->imgMaximumWidth;
		}

		function getImageMinimumWidth()
		{
			return $this->imgMinimumWidth;
		}

		function getImageMaximumHeight()
		{
			return $this->imgMaximumHeight;
		}

		function getImageMinimumHeight()
		{
			return $this->imgMinimumHeight;
		}

		function setImageMinimumSize($width, $height)
		{
			$this->imgMinimumWidth = intval($width);
			$this->imgMinimumHeight = intval($height);
		}

		function setImageMaximumSize($width, $height)
		{
			$this->imgMaximumWidth = intval($width);
			$this->imgMaximumHeight = intval($height);
		}

		function checkImageErrors()
		{
			$this->checkErrors(); //upload errors

			if($this->hasErrors()) {
				return;
			}

			$info = @getimagesize($this->tmpName);

			if($info === false) {
				$this->errors[] = UPLOADMSG_IMG_INVALID;
				return;
			}

			//for stupid people:
			if($this->imgMaximumWidth <	$this->imgMinimumWidth || $this->imgMaximumHeight <	$this->imgMinimumHeight) {
				return;
			}

			$width = $info[0];
			$height = $info[1];

			if($this->imgMaximumWidth && $this->imgMaximumHeight && 
				($this->imgMaximumWidth < $width  ||  $this->imgMaximumHeight < $height)) {
				$this->errors[] = str_replace(array('[WIDTH]', '[HEIGHT]'), array($this->imgMaximumWidth, $this->imgMaximumHeight), UPLOADMSG_IMG_TOO_BIG);
				return;
			}
			
			if($this->imgMinimumWidth && $this->imgMinimumHeight && 
				($this->imgMinimumWidth >	$width  ||  $this->imgMinimumHeight > $height)) {
				$this->errors[] = str_replace(array('[WIDTH]', '[HEIGHT]'), array($this->imgMinimumWidth, $this->imgMinimumHeight), UPLOADMSG_IMG_TOO_SMALL);
			}
		}

		function saveConvert($destination)
		{
			$this->checkImageErrors();

			if($this->hasErrors()) {
				return null;
			}
			
			if ($this->autoRename && !$this->overwriteFiles) {
				$destination = $this->_getUniqueName($destination);
				$this->name = basename($destination);
			}

			if (@is_file($destination)) {
				if(!$this->overwriteFiles) {
					$this->errors[] = UPLOADMSG_FILE_EXISTS;
					return null;
				} else if(!is_writable($destination)){
					$this->errors[] = UPLOADMSG_CANNOT_OVERWRITE;
					return null;
				}
			}

			if($this->overwriteFiles && file_exists($destination)) {
				@unlink($destination);
			}

			$img = new Image($this->tmpName);
			$ret = $img->save($destination);
			$img->destroy();

			return $ret;
		}

		function saveResized($width, $height, $filePath = null)
		{
			$this->checkImageErrors();

			if($this->hasErrors()) {
				return null;
			}

			if (is_null($filePath)) {
				$savePath = $this->getSavePath();
			} else {
				$savePath = $filePath;
			}

			if ($this->autoRename && !$this->overwriteFiles) {
				$savePath = $this->_getUniqueName($savePath);
				$this->name = basename($savePath);
			}

			if (@is_file($savePath)) {
				if(!$this->overwriteFiles) {
					$this->errors[] = UPLOADMSG_FILE_EXISTS;
					return null;
				} else if(!is_writable($savePath)){
					$this->errors[] = UPLOADMSG_CANNOT_OVERWRITE;
					return null;
				}
			}

			if($this->overwriteFiles && file_exists($savePath)) {
				@unlink($savePath);
			}

			$img = new Image($this->tmpName);

			$ret = $img->resize($width, $height, $savePath);
			$img->destroy();

			return $ret;
		}

		function saveResizedMaxDimensions($width, $height, $filePath = null)
		{
			$this->checkImageErrors();

			if($this->hasErrors()) {
				return null;
			}

			if (is_null($filePath)) {
				$savePath = $this->getSavePath();
			} else {
				$savePath = $filePath;
			}

			if ($this->autoRename && !$this->overwriteFiles) {
				$savePath = $this->_getUniqueName($savePath);
				$this->name = basename($savePath);
			}

			if (@is_file($savePath)) {
				if(!$this->overwriteFiles) {
					$this->errors[] = UPLOADMSG_FILE_EXISTS;
					return null;
				} else if(!is_writable($savePath)){
					$this->errors[] = UPLOADMSG_CANNOT_OVERWRITE;
					return null;
				}
			}

			if($this->overwriteFiles && file_exists($savePath)) {
				@unlink($savePath);
			}

			$img = new Image($this->tmpName);

			$ret = $img->resizeMaxDimensions($width, $height, $savePath);
			$img->destroy();

			return $ret;
		}

		function saveResizedCrop($width, $height, $filePath = null)
		{
			$this->checkImageErrors();

			if($this->hasErrors()) {
				return false;
			}

			if (is_null($filePath)) {
				$savePath = $this->getSavePath();
			} else {
				$savePath = $filePath;
			}

			if ($this->autoRename && !$this->overwriteFiles) {
				$savePath = $this->_getUniqueName($savePath);
				$this->name = basename($savePath);
			}

			if (@is_file($savePath)) {
				if(!$this->overwriteFiles) {
					$this->errors[] = UPLOADMSG_FILE_EXISTS;
					return null;
				} else if(!is_writable($savePath)){
					$this->errors[] = UPLOADMSG_CANNOT_OVERWRITE;
					return null;
				}
			}

			if($this->overwriteFiles && file_exists($savePath)) {
				@unlink($savePath);
			}

			$img = new Image($this->tmpName);

			$ret = $img->resizeCrop($width, $height, $savePath);
			$img->destroy();

			return $ret;
		}

		function saveResizedWithBg($width, $height, $bgcolor = '#FFFFFF', $filePath = null)
		{
			$this->checkImageErrors();

			if($this->hasErrors()) {
				return null;
			}

			if (is_null($filePath)) {
				$savePath = $this->getSavePath();
			} else {
				$savePath = $filePath;
			}

			if ($this->autoRename && !$this->overwriteFiles) {
				$savePath = $this->_getUniqueName($savePath);
				$this->name = basename($savePath);
			}

			if (@is_file($savePath)) {
				if(!$this->overwriteFiles) {
					$this->errors[] = UPLOADMSG_FILE_EXISTS;
					return null;
				} else if(!is_writable($savePath)){
					$this->errors[] = UPLOADMSG_CANNOT_OVERWRITE;
					return null;
				}
			}

			if($this->overwriteFiles && file_exists($savePath)) {
				@unlink($savePath);
			}

			$img = new Image($this->tmpName);

			$ret = $img->resizeWithBg($width, $height, $bgcolor, $savePath);
			$img->destroy();

			return $ret;
		}
	}
