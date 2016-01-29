<?php

	/**
	 * Configurari dinamice generale ale siteului (folosind o tabela din baza de date).
	 * Citeste setarile dintr-un singur row (ceea ce permite folosirea a mai multor setari dinamice simultane)
	 * Poate lucra doar cu valori scalare.
	 *
	 */
	class DynamicConfig
	{
		var $table_name = 'general_config';
		var $id;

		var $settings = array();

		/**
		 * Constructorul. Daca se specifica un $id, se citest proprietatile corespunzatoare id-ului respectiv.
		 * Fiecare field esre o proprietate.
		 *
		 * Daca nu, se citeste setarile din primul record, din tabela specificata.
		 *
		 * @param integer $id
		 * @return SiteConfig
		 */
		function DynamicConfig($id = null)
		{
			$this->setId($id);
		}
		
		/**
		 * Returneaza numele tabelei folosite
		 *
		 * @return string
		 */
		function getTableName()
		{
			return $this->table_name;
		}
		
		/**
		 *   Seteaza numele tabelei folosite
		 *
		 * @param string $id
		 */		
		function setTableName($name)
		{
			$this->table_name = $name;
		}

		/**
		 * Returneaza id-ul folosit
		 *
		 * @return int
		 */
		function getId()
		{
			return $this->id;
		}

		/**
		 * Citeste setarile corespunzatoare id-ului(ca si constuctorul).
		 *
		 * @param integer $id
		 */
		function setId($id = null)
		{
			if(is_null($id)) {
				#primul row:
				$query = "SELECT * FROM {$this->table_name}";
			} else {
				$this->id = intval($id);
				$query = "SELECT * FROM {$this->table_name} WHERE id = {$this->id}";
			}

			$q = new DB_Sql($query);
			$q->next_record();

			$this->settings = $q->getRecord();
		}

		/**
		 * Returneaza valoarea unei proprietati, daca aceasta exista.
		 *
		 * @param string $var
		 * @return string
		 */
		function get($var)
		{
			if(isset($this->settings[$var])){
				return $this->settings[$var];
			}

			return null;
		}

		/**
		 * Seteaza valoarea unei proprietati la valoarea indicata.
		 * Daca proprietatea nu exista deja (nu a fost citita), NU este setata.
		 *
		 * @param string $var
		 * @param string $val
		 */
		function set($var, $val = null)
		{
			if(is_array($var)){
				foreach($var as $k => $v){
					if(isset($this->settings[$k])){ #nu seteaza daca nu exista, ca sa nu fie eroare de sql
						$this->settings[$k] = $v;
					}
				}
			}else{
				if(isset($this->settings[$var])){ #nu seteaza daca nu exista, ca sa nu fie eroare de sql
					$this->settings[$var] = $val;
				}
			}
		}

		/**
		 * Returneaza un array asociativ cu proprietatile.
		 *
		 * @return array
		 */
		function getSettings()
		{
			return $this->settings;
		}

		/**
		 * Actualizeaza in baza de date proprietatile setate curent.
		 *
		 */
		function update()
		{
			if(count($this->settings)) {
				$query = "UPDATE {$this->table_name} SET ";

				foreach($this->settings as $k => $v){
					$query .= $k.' = \''.addslashes($v).'\', ';
				}
				$query = rtrim($query, ', ');

				$q = new DB_Sql($query);
			}
		}
	}

