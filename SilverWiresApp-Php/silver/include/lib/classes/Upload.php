<?php

	/**
	 * Clasa se ocupa de upload de fisiere, si aplica criterii validare dupa extensie si marime.
	 *
	 */
	class Upload
	{
		var $field;

		var $name;
		var $tmpName;
		var $contentType;
		var $size;
		var $error;

		var $minSize			= null;
		var $maxSize			= null;
		var $allowedExt			= array();

		var $errors				= array();
		var $savePath			= null;

		var $overwriteFiles		= true;
		var $autoRename			= true;
		var $chmod				= 0777;

		/**
		 * Initializeaza obiectul in functie de numele fiedului de upload (din $_FILES).
		 * Daca requestul curent nu este prin POST, sau daca nu este de tip 'multipart/form-data',
		 * se genereaza o eroare.
		 *
		 * Cand $allowed_ext este specificat, este folosit pentru a face validare dupa extensie.
		 *
		 * @param string $uploadField
		 * @param mixed $allowed_ext
		 * @return Upload
		 */
		function Upload($uploadField, $allowed_ext = null, $index = null)
		{

			if (
				strtoupper($_SERVER['REQUEST_METHOD']) != 'POST' ||
				empty($_SERVER['CONTENT_TYPE']) ||
				strpos($_SERVER['CONTENT_TYPE'], 'multipart/form-data') !== 0) {
				$this->errors[] = UPLOADMSG_BAD_FORM;
				return;
            }

			if (empty($_FILES[$uploadField])) {
				$this->errors[] = UPLOADMSG_NO_INPUT;
				return;
			}
			
			$upload = $_FILES[$uploadField];
			$this->field = $uploadField;
			
			if (!is_null($index)) {
				$this->name = $this->_getSafeName(basename($upload['name'][$index]));
				$this->tmpName = $upload['tmp_name'][$index];
				$this->contentType = $upload['type'][$index];
				$this->size = $upload['size'][$index];
				$this->error = $upload['error'][$index];
			} else {
				$this->name = $this->_getSafeName(basename($upload['name']));
				$this->tmpName = $upload['tmp_name'];
				$this->contentType = $upload['type'];
				$this->size = $upload['size'];
				$this->error = $upload['error'];
			}

			if(!is_null($allowed_ext)) {
				$this->setAllowedExtensions($allowed_ext);
			}
		}

		/**
		 * Returneaza numele si extesia fisierului.
		 * ex: poza.jpg
		 *
		 * @return string
		 */
		function getFileName()
		{
			return $this->name;
		}

		/**
		 * Returneaza marimea fisierului in bytes(octeti).
		 *
		 * @return integer
		 */
		function getFileSize()
		{
			return $this->size;
		}

		/**
		 * Returneaza calea absoluta a fisieruli
		 * ex: c:/appserv/www/imagini/poza.jpg
		 *
		 * @return string
		 */
		function getSavePath()
		{
			return rtrim($this->savePath, '/') . '/' . $this->name;
		}

		/**
		 * Seteaza directorul unde se va salva.
		 *
		 * @param string $path
		 */
		function setSavePathDirectory($path)
		{
			$this->savePath = $path;
		}

		/**
		 * Seteaza marimea maxima a fisierului care
		 * a fost uploadat
		 *
		 * @param int $size
		 */
		function setMaximumSize($size)
		{
			$this->maxSize = $size;
		}

		/**
		 * Seteaza marimea minima a fisierului care
		 * a fost uploadat
		 *
		 * @param int $size
		 */
		function setMinimumSize($size)
		{
			$this->minSize = $size;
		}

		/**
		 * Seteaza numele cu extensie cu care va fi salvat fisierul.
		 *
		 * @param string $fileName
		 */
		function setFileName($fileName)
		{
			$this->name = $this->_getSafeName($fileName);
		}

		/**
		 * Returneaza valoarea chmod cu care va fi copiat fisierul uploadat in locatia finala.
		 *
		 * @return mixed
		 */
		function getChmod()
		{
			return $this->chmod;
		}

		/**
		 * Seteaza valorea chmod cu care va fi copiat fisierul. Default, este 0777.
		 *
		 * @param mixed $chmod
		 */
		function setChmod($chmod)
		{
			$this->chmod = $chmod;
		}

		/**
		 * Seteaza valoarea fieldului $this->overwriteFiles.
		 * Cand acesta este true, fisierul uploadat este intotdeauna suprascris peste
		 * fisierul existent in locatia finala.
		 *
		 * @param boolean $bool
		 */
		function setOverwriteFiles($bool = true)
		{
			$this->overwriteFiles = $bool;
		}

		/**
		 * Functie accesor de tip 'get', care returneaza valoarea fieldului $this->overwriteFiles.
		 *
		 * @return boolean
		 */
		function isOverwriteFiles()
		{
			return $this->overwriteFiles;
		}

		/**
		 * Setter pentru $this->autoRename. Cand acesta este true si exista un fisier cu nume identic cu cel uploadat,
		 * se va genera un nume de fisier asemanator, pentru a nu suprascrie acest fisier.
		 *
		 * Cand $this->overwriteFiles este true, acest field este ignorat.
		 *
		 * @param boolean $bool
		 */
		function setAutoRenameFiles($bool = true)
		{
			$this->autoRename = $bool;
		}

		/**
		 * Getter pentru $this->autoRename.
		 *
		 * @return boolean
		 */
		function isAutoRenameFiles()
		{
			return $this->autoRename;
		}


		/**
		 * Seteaza extensiile care pot fi uploadate
		 * despartite prin virgula, sau array.
		 * ex:
		 * $upload->setAlowedExtensions('jpg,gif,png');
		 * $upload->setAlowedExtensions(array('jpg', 'gif', 'png');
		 *
		 * @param mixed $ext
		 */
		function setAllowedExtensions($ext)
		{
			if(is_array($ext)) {
				$this->allowedExt = array_values($ext);
			} else {
				$this->allowedExt = explode(',', str_replace(array('|', '.'), ',', $ext));
			}
		}

		/**
		 * Returneaza array-ul cu erori generate pt acest upload.
		 * Erorile sunt generate plain text, folosind constantele definite la inceputul fisierului.
		 *
		 * In cazul cand se folosesc mai multe limbi, este indicat sa se defineasca aceste constante in toate limbile
		 * permise, in fisiere separate.
		 *
		 * @return array
		 */
		function getErrors()
		{
			return $this->errors;
		}

		/**
		 * Returneaza prima eroare.
		 *
		 * @return string
		 */
		function getFirstError()
		{
			if(isset($this->errors[0])) {
				return $this->errors[0];
			}

			return null;
		}

		/**
		 * Face o verificare de erori, in functie de criteriile selectate.
		 * Daca o eroare este gasita, este adaugata impreuna cu celelalte erori gasite.
		 *
		 * Functia este apelata automat cand se salveaza fisierul, dar se poate apela in orice moment.
		 *
		 * ATENTIE: functia sterge toate erorile existente folosind resetErrors, inainte de a face verificarea.
		 * Erorile anterioare se pierd, si se genereaza un nou set de erori (daca este cazul).
		 *
		 */
		function checkErrors()
		{
			$this->resetErrors();

			if (!is_uploaded_file($this->tmpName)) {
				$this->errors[] = UPLOADMSG_NO_USER_FILE;
				return;
			}

			switch($this->error) {
                case UPLOAD_ERR_OK:
                    // all is OK
                    break;
                case UPLOAD_ERR_INI_SIZE:
                    $this->errors[] = str_replace('[MAXSIZE]', ini_get('upload_max_filesize'), UPLOADMSG_TOO_LARGE);
                    break;
                case UPLOAD_ERR_FORM_SIZE:
                    $this->errors[] = str_replace('[MAXSIZE]', @$_REQUEST['MAX_FILE_SIZE'], UPLOADMSG_TOO_LARGE);
                    break;
                case UPLOAD_ERR_PARTIAL:
                    $this->errors[] = UPLOADMSG_PARTIAL;
                    break;
                case UPLOAD_ERR_NO_FILE:
                    $this->errors[] = UPLOADMSG_NO_USER_FILE;
                    break;
                default:
                    $this->errors[] = UPLOADMSG_ERROR;
             }

			 $ext = $this->_getfileExt($this->name);

             if ($this->_isNotAllowedExt($ext)) {
             	$this->errors[] = UPLOADMSG_FORBIDDEN_EXTENSION;
             }

             if (is_array($this->allowedExt) && count($this->allowedExt) && !in_array($ext, $this->allowedExt)) {
             	$this->errors[] = UPLOADMSG_NOT_ALLOWED_EXTENSION;
             }

			if ($this->minSize && $this->size < $this->minSize) {
				$this->errors[] = str_replace('[MINSIZE]', $this->minSize, UPLOADMSG_TOO_SMALL);
			}else if ($this->maxSize && $this->size > $this->maxSize){
				$this->errors[] = str_replace('[MAXSIZE]', $this->maxSize, UPLOADMSG_TOO_LARGE);
			}
		}

		/**
		 * Returneaza true daca exista cel putin o eroare.
		 *
		 * @return boolean
		 */
		function hasErrors()
		{
			return (bool) count($this->errors);
		}

		/**
		 * Sterge toate erorile setate.
		 *
		 */
		function resetErrors()
		{
			$this->errors = array();
		}

		/**
		 * Verifica daca exista erori. Daca nu sunt erori, se salveaza fisierul uploadat la locatia specificata ca parametru,
		 * sau in directorul specificat prin setSavePathDirectory.
		 *
		 * Daca operatia a reusit si fisierul a fost salvat, se returneaza true. Daca au aparut erori, se returneaza false iar
		 * fisierul NU este copiat in locatia finala.
		 *
		 * @return boolean
		 */
		function save($filePath = null)
		{
			$this->checkErrors();

			if (count($this->errors)) {
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
					return;
				} else if(!is_writable($savePath)){
					$this->errors[] = UPLOADMSG_CANNOT_OVERWRITE;
					return;
				}
			}

			if($this->overwriteFiles && file_exists($savePath)) {
				@unlink($savePath);
			}

			if(!@copy($this->tmpName, $savePath)) {
				$this->errors[] = UPLOADMSG_SAVE_FAIL;
				return;
			}

			@chmod($savePath, $this->chmod);

			return true;
		}

		/**
		 * Calculeaza un nume unic, care nu exista, pentru un fisier/path specificat.
		 *
		 * @param string $filename
		 * @return string
		 *
		 * @access private
		 */
		function _getUniqueName($filename)
		{
			$name = $this->_getfileName($filename);
			$ext = $this->_getfileExt($filename);

			$i = 1;
			while (file_exists($filename)) {
				$filename = $name . '('.$i++.').' . $ext;
			}

			return $filename;
		}

		/**
		 * Genereaza un nume safe pt fisier, in cazul in care exista caractere speciale.
		 * Numele este trunchiat nr. de caractere specificat. Default, 250 este maximul.
		 *
		 * @param string $name
		 * @param integer $maxlen
		 * @return string
		 *
		 * @access private
		 */
		function _getSafeName($name, $maxlen=250)
		{
	        $noalpha = '�����������������������������������������������������@���';
			$alpha   = 'AEIOUYaeiouyAEIOUaeiouAEIOUaeiouAEIOUaeiouyAaOoAaNnCcaooa';

			$name = substr($name, 0, $maxlen);
			$name = strtr($name, $noalpha, $alpha);

			// not permitted chars are replaced with "_"
			return preg_replace('/[^a-zA-Z0-9,._\+\()\-]/', '_', $name);
		}

		/**
		 * Returneaza true daca extensia specificata nu este in lista cu extensiile de fisiere care NU sunt permise.
		 * Aceste extensii sunt interzise, chiar daca sunt specificate de catre script.
		 *
		 * @param string $ext
		 * @return boolean
		 *
		 * @access private
		 */
		function _isNotAllowedExt($ext)
		{
			return in_array($ext, array('php', 'phtml', 'shtml', 'php3', 'sh', 'exe', 'pl', 'py', 'jsp', 'asp', 'aspx', 'htaccess'));
		}

		/**
		 * Returneaza extensia unui fisier.
		 *
		 * @param string $filename
		 * @return string
		 *
		 * @access private
		 */
		function _getfileExt($filename)
		{
			return strtolower(substr(strrchr($filename, '.'), 1));
		}

		/**
		 * Returneaza numele unui fisier, mai putin extensia sa.
		 *
		 * @param string $filename
		 * @return string
		 *
		 * @access private
		 */
		function _getfileName($filename)
		{
			$pos = strrpos($filename, '.');
			if($pos === false) {
				return $filename;
			}

			return substr($filename, 0, $pos);
		}
	}
