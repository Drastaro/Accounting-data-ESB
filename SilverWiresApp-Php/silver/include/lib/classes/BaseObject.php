<?php

	/**
	 * BaseObject class.
	 *
	 * Author: Jumpeye Creative Media
	 *
	 * (C) Copyright 2005 Jumpeye Creative Media http://www.jumpeye.com. All rights reserved.
	 *
	 */
	class BaseObject
	{
		/**
		 * Constructor.
		 * Daca este specificat un $id, se va citi din baza de date recordul asociat cu
		 * acel $id (daca exista unul).
		 *
		 * @param int $id
		 * @return BaseObject;
		 */
		public function __construct($id = null)
		{
			if (empty($id)) {
				$this->emptyRecord();
			} else {
				$this->readId($id);
			}
		}

		/**
		 * Returneaza identificatorul conexiunii setate in config.
		 * Trebuie suprascrisa corezpunzator.
		 *
		 * @return string - numele tabelei
		 */
		public function getDatabase()
		{
			return 'default';
		}

		/**
		 * Returneaza numele tabelei.
		 * Trebuie suprascrisa corezpunzator.
		 *
		 * @return string - numele tabelei
		 */
		public function getTableName()
		{
			return '';
		}

		/**
		 * Returneaza un array cu toate fieldurile folosite.
		 * Trebuie suprascrisa corezpunzator.
		 *
		 * @return array
		 */
		public function getFields()
		{
			return array();
		}

		/**
		 * Seteaza recordul $record in obiectul curent.
		 *
		 * @param array $record
		 */
		public function setRecord($record)
		{
			$fields = $this->getFields();

			foreach ($record as $key => $value) {
				if(in_array($key, $fields)) {
					if (trim($value) == '' && (!isset($this->$key) || trim($value) == $this->$key)) {
						$this->$key = null;
					} else {
						$this->$key = trim($value);
					}
				}
			}
		}

		/**
		 * Returneaza un array asociativ cu toate fieldurile si valorile.
		 * Cu alte cuvinte, returneaza recordul curent.
		 *
		 * @return array
		 */
		public function getRecord()
		{
			$record = get_object_vars($this);

			$fields = $this->getFields();
			foreach($record as $k => $v) {
				if(!in_array($k, $fields)) {
					unset($record[$k]);
				}
			}

			return $record;
		}

		/**
		 * Seteaza ca null recordul curent (toate fieldurile devin null).
		 *
		 */
		public function emptyRecord()
		{
			$fields = $this->getFields();

			foreach ($fields as $value) {
				$this->$value = null;
			}
		}

		/**
		 * Seteaza in obiectul curent recordul corespunzator unui id din baza de date
		 *
		 * @param int $id
		 */
		public function readId($id)
		{
			$id = intval($id);
			$fields = '`' . implode('`,`', $this->getFields()) . '`';

			$query = "SELECT {$fields} FROM `" . $this->getTableName() . "` WHERE `id`  = '{$id}'";
			$q = new DbMySql($query, $this->getDatabase());

			if ($q->nextRecord()) {
				$this->setRecord($q->getRecord());
				return true;
			} else {
				$this->emptyRecord();
				return false;
			}
		}

		/**
		 * Returneaza valoarea unui camp din baza de date daca acesta exista.
		 * Altfel returneaza null. Unele fielduri vor avea in baza de date valoarea NULL, ceea ce
		 * inseamna ca unele fielduri vor exista, dar vor fi setate cu null.
		 *
		 * @param string $field
		 * @return field
		 */
		public function get($field)
		{
			if (isset($this->$field)) {
				return $this->$field;
			}

			return null;
		}
		
		public function readField($field, $value)
		{
			$q = new DbMySql(null, $this->getDatabase());
			
			$field = $q->realEscape($field);
			$value = $q->realEscape($value);
			
			$fields = '`' . implode('`,`', $this->getFields()) . '`';

			$query = "SELECT {$fields} FROM `" . $this->getTableName() . "` WHERE `{$field}`  = '{$value}'";
			$q->query($query);
			
			if ($q->nextRecord()) {
				$this->setRecord($q->getRecord());
				return true;
			} else {
				$this->emptyRecord();
				return false;
			}
		}
		

		/**
		 * Seteaza un field cu o valoare. Doar fieldurile valide (returnate de getFields) sunt setate.
		 *
		 * @param string $field
		 * @param mixed $value
		 */
		public function set($field, $value = null)
		{
			if (in_array($field, $this->getFields())) {
				$this->$field = $value;
			}
		}

		/**
		 * Insereaza o noua inregistrare in baza de date.
		 *
		 * Daca se specifica un $order_field, acesta va fi actualizat cu valoarea id-ului care tocmai a fost inserat.
		 * Scopul este pentru a folosi mai usor ordonarea in tabela, pe baza unui field de tip intreg,
		 * si eventual a unei conditii.
		 *
		 * Dupa executia functiei, $this->id primeste valoarea id-ului care tocmai a fost inserat.
		 *
		 * @param string $order_field
		 *
		 */
		public function insert($orderField = null)
		{
			$fields = $this->getRecord();
			unset($fields['id']);

			$q = new DbMySql(null, $this->getDatabase());
			$querySet = '';
			foreach ($fields as $key => $value) {
				if(is_null($value)) {
					continue;
				}

				$querySet .= "`{$key}` = '" . $q->realEscape($value) . "', ";
			}
			$querySet = rtrim($querySet, ', ');

			if(!$querySet) {
				return;
			}

			$query = 'INSERT INTO `'. $this->getTableName() . '` SET ' . $querySet;
			$q->query($query);

			$this->id = $q->insertId();

			if(!is_null($orderField)) {
				$this->setupOrder($orderField);
			}
		}

		/**
		 * Actualizeaza valoarea unui field integer la valoarea id-ului din recordul curent.
		 * Este util pentru ordonarea recordurilor.
		 *
		 * Preferabil este sa nu fie apelat direct.
		 *
		 * @param string $field
		 */
		public function setupOrder($field = 'display_order')
		{
			$id = (int) $this->id;
			if(!$id) {
				return;
			}

			$query = "UPDATE `". $this->getTableName() . "` SET `{$field}` = id WHERE id = {$id}";
			new DbMySql($query, $this->getDatabase());
		}

		/**
		 * Face update la obiectul curent in baza de date.
		 *
		 */
		public function update()
		{
			$fields = $this->getRecord();
			unset($fields['id']);

			$q = new DbMySql(null, $this->getDatabase());
			$querySet = '';
			foreach ($fields as $key => $value) {
				if(is_null($value)) {
					continue;
				}

				$querySet .= "`{$key}` = '" . $q->realEscape($value) . "', ";
			}
			
			$querySet = rtrim($querySet, ', ');

			if(!$querySet) {
				return;
			}

			$id = (int) $this->id;
			$query = "UPDATE `". $this->getTableName() . "` SET {$querySet} WHERE id = {$id}";
			$q->query($query);
		}

		/**
		 * Salveaza obiectul curent in baza de date. Face update sau insert, in functie de $this->id;
		 * daca este setat, se face update, altfel se face insert.
		 *
		 * Daca se specifica $order_field si $this->id == null, se va face un insert, si se va actualiza
		 * fieldul folosit pentru ordonarea recordurilor.
		 *
		 * @param string $order_field
		 */
		public function save($orderField = null)
		{
			if (empty($this->id)) {
				$this->insert($orderField);
			} else {
				$this->update();
			}
		}

		/**
		 * Verifica daca exista un id in baza de date.
		 * Functia este statica, deci se poate apela direct: BaseObject::exists($id);
		 *
		 * @param int $id
		 * @return boolean
		 */
		public function exists($id)
		{
			$id = (int) $id;
			$query = "SELECT `id` FROM `" . $this->getTableName() . "` WHERE id = '{$id}'";
			$q = new DbMySql($query, $this->getDatabase());

			return (bool)$q->nextRecord();
		}

		/**
		 * Returneaza numarul inregistrarilor din baza de date.
		 * Se poate specifica o conditie pentru care se va face numararea.
		 *
		 * @param string $condition
		 * @return int
		 */
		public function getCount($condition = '')
		{
			$query = "SELECT count(*) as total FROM `" . $this->getTableName() . '` ' . $condition;
			$q = new DbMySql($query, $this->getDatabase());

			if ($q->nextRecord()) {
				return $q->f('total');
			}

			return 0;
		}

		/**
		 * Returneaza un array cu obiecte, pentru fiecare record care corespunde cu criteriul specificat.
		 * Se poate specifica un criteriu in parametrul $append, la fel cu alte clauze mysql. Ex:
		 * $all = $this->getAll('WHERE parent_id=2 ORDER BY id DESC LIMIT 3');
		 *
		 * Daca se specifica $fields ca array, obiectele extrase vor avea setate doar fieldurile specificate.
		 *
		 * @param string $condition
		 * @param string $fields
		 * @return array
		 */
		public function getAll($append = '', $fields = null)
		{
			$ret = array();
			if (empty($fields)) {
				$fields = '`' . implode('`, `', $this->getFields()) . '` ';
			} else {
				$fields = 'id, '. $fields;
			}

			$query = "SELECT $fields FROM " . $this->getTableName() . ' ' . $append;

			$q = new DbMySql($query, $this->getDatabase());
			$className = get_class($this);
			while ($q->nextRecord()) {
				$obj = new $className;
				$obj->setRecord($q->getRecord());
				$ret[$obj->id] = $obj;
			}

			return $ret;
		}

		/**
		 * Testeaza daca obiectul are un id specificat.
		 *
		 * @return boolean
		 */
		public function isValid()
		{
			return !empty($this->id);
		}
		
		public function delete()
		{
			if($this->id){
				$id = (int) $this->id;
				$query = "delete from `" . $this->getTableName() . "` where `id`='$id'";
				$q = new DbMySql($query, $this->getDatabase());
				
				if ($q->affectedRows()) {
					$this->id = null;
					return true;
				}
			}
			return false;
		}

		/**
		 * Muta o inregistrare din baza de date 'in sus'. Practic schimba valoarea fieldului folosit pentru ordonare.
		 * Acesta trebuie sa fie de tip intreg.
		 *
		 * Se poate specifica o conditie pentru care sa se mute recordul.
		 *
		 * @param string $condition
		 * @param string $display_field
		 * @return int - pozitia
		 */
		public function moveUp($condition = null, $displayField = 'display_order')
		{
			if(empty($this->id)){
				return;
			}

			if ($this->$displayField <= 1) {
				return;
			}

			if (is_null($condition)) {
				$condition = '1';
			}

			$query = "SELECT id, `{$displayField}` FROM `" . $this->getTableName() . "`
						WHERE `{$displayField}` < " . intval($this->$displayField) . " AND {$condition}
						ORDER  BY `{$displayField}` DESC
						LIMIT 1";
			$q = new DbMySql($query, $this->getDatabase());
			if(!$q->nextRecord()){
				return;
			}

			$swapId = (int) $q->f('id');
			$newOrder = (int) $q->f($displayField);

			$thisId = (int) $this->id;
			$query = "UPDATE `" . $this->getTableName() . "` SET `{$displayField}` = {$newOrder} WHERE id = {$thisId}";
			$q->query($query);

			$query = "UPDATE `" . $this->getTableName() . "` SET `{$displayField}` = " . intval($this->$displayField) . " WHERE id = {$swapId}";
			$q->query($query);

			$this->$displayField = $newOrder;

			return $newOrder;
		}

		/**
		 * Muta o inregistrare din baza de date 'in jos', schimband valoarea fieldului folosit pentru ordonare.
		 * Se poate specifica o conditie pentru care sa se mute recordul.
		 *
		 * @param string $condition
		 * @param string $display_field
		 * @return int - pozitia
		 */
		public function moveDown($condition = null, $displayField = 'display_order')
		{
			if(empty($this->id)){
				return;
			}

			if (is_null($condition)) {
				$condition = '1';
			}

			$query = "SELECT id, `$displayField` FROM `" . $this->getTableName() . "`
					WHERE `{$displayField}` > '" . intval($this->$displayField) . "' AND {$condition}
					ORDER  BY `{$displayField}` ASC
					LIMIT 1";
			$q = new DbMySql($query, $this->getDatabase());
			if(!$q->nextRecord()){
				return;
			}

			$swapId = (int) $q->f('id');
			$newOrder = (int) $q->f($displayField);
			$thisId = (int) $this->id;

			$query = "UPDATE `" . $this->getTableName() . "` SET `{$displayField}` = {$newOrder} WHERE id = {$thisId}";
			$q->query($query);

			$query = "UPDATE `" . $this->getTableName() . "` SET `{$displayField}` = " . intval($this->$displayField) . " WHERE id = {$swapId}";
			$q->query($query);

			$this->$displayField = $newOrder;

			return $newOrder;
		}

		public function now()
		{
			return date("Y-m-d H:i:s");
		}
	
		public function query($query)
		{
			$q = new DbMySql($query, $this->getDatabase());
			$ret = array();
			$className = get_class($this);
			while ($q->nextRecord()){
				$record = $q->getRecord();
				$obj = new $className;
				foreach ($record as $fieldName => $fieldValue){
					$obj->$fieldName = $fieldValue;
				}
				$ret[] = $obj;
			}
			return $ret;
		}
		
		public function scalar($query)
		{
			$q = new DbMySql($query, $this->getDatabase());
			if ($q->nextRecord()) {
				return reset($q->getRecord());
			}
			return null;
		}
	}

