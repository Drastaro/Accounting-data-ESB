<?php

	class Companies extends BaseObject
	{
        public
            $id,
            $user_id,
            $name,
			$cui,
			$isDemo,
			$balante;
		
		public function getTableName()
		{
			return 'companies';
		}
		
		public function getFields()
		{
			return array ( 'id', 'user_id', 'name', 'cui', 'isDemo' );
		}

        public function getList($append)
        {
            $users = new Users;

            $ret = array();
            $fields = "`{$this->getTableName()}`.`" . implode("`, `{$this->getTableName()}`.`", $this->getFields()) . "`, "
                    . " CONCAT_WS(' ', `{$users->getTableName()}`.`first_name`, `{$users->getTableName()}`.`last_name`) AS `user_name` ";

            $query =  " SELECT $fields FROM " . $this->getTableName()
                    . " LEFT JOIN " . $users->getTableName()
                        . " ON " . $users->getTableName() . ".id=" . $this->getTableName() . ".user_id "
                    . " " . $append;

            $q = new DbMySql($query, $this->getDatabase());
            $className = get_class($this);
            while ($q->nextRecord()) {
                $obj = new $className;
                $obj->setRecord($q->getRecord());
                $obj->user_name = $q->f('user_name');
                $ret[$obj->id] = $obj;
            }

            return $ret;
        }
		
		public function getCompaniesList($append)
        {
            $users = new Users;

            $ret = array();
            $fields = "`{$this->getTableName()}`.`" . implode("`, `{$this->getTableName()}`.`", $this->getFields()) . "` ";
                    

            $query =  " SELECT $fields FROM " . $this->getTableName()
                    . " " . $append;
			
            $q = new DbMySql($query, $this->getDatabase());
            $className = get_class($this);
            while ($q->nextRecord()) {
                $obj = new $className;
                $obj->setRecord($q->getRecord());
               
                $ret[$obj->id] = $obj;
            }

            return $ret;
        }

        public static function getUserCompanyById($companyId, $userId) {
			 $self = new self;
           $ret = null;
            $fields = "`{$self->getTableName()}`.`" . implode("`, `{$self->getTableName()}`.`", $self->getFields()). "` ";

            $query =  " SELECT $fields FROM " . $self->getTableName(). " WHERE `id`=".$companyId. " and `user_id`=".$userId;

            $q = new DbMySql($query, $self->getDatabase());
            $className = get_class($self);
            while ($q->nextRecord()) {
                $obj = new $className;
                $obj->setRecord($q->getRecord());
                $ret = $obj;
            }

            return $ret;

        }

        public static function getUserCompanies($userId)
        {
            $self = new self;
            return $self->getList( "WHERE `user_id`=" . intval($userId) . " and `isDemo` is null or isDemo!=1 ORDER BY `name` ASC" );
        }
		
		public static function getDemoCompany($userId)
        {
            $self = new self;
            return $self->getCompaniesList( "WHERE `user_id`=" . intval($userId) . " and `isDemo`=1 ");
        }
		
		
		
		public static function getUserCompaniesWithBalante($userId)
        {
            $self = new self;
            $list=$self->getList( "WHERE `user_id`=" . intval($userId) . " ORDER BY `name` ASC" );
			foreach($list as $comp) {
			      $comp->balante=Balante::getCompanyBalante($comp->id);
			}
			
			return $list;
        }

        public static function getUserCompany($companyId, $userId)
        {
            $self = new self;
            return $self->getUserCompanyById($companyId, $userId);
        }
		
		public static function getUserCompanyWithBalante($companyId, $userId)
        {
            $self = new self;
            $comp=$self->getUserCompanyById($companyId, $userId);
			$comp->balante=Balante::getCompanyBalante($comp->id);
			return $comp;
        }

        public static function register($post)
        {
            if (!empty($post['name'])) {
                $companie = new self;
                $companie->user_id = Users::getLogged()->id;
                $companie->name = $post['name'];
				$companie->cui = $post['companie_cui'];
                $companie->insert();

                if ( !empty($companie->id) ) {
					Messages::addNotice("Compania <b>". $companie->name ."</b> a fost creata.");
					
					//add the balance score cards from template
					$query =  " SELECT * FROM card_items_template";
					$q = new DbMySql($query, $companie->getDatabase());
					
					while ($q->nextRecord()) {
						Companies::registerCompanyCard($companie->id,$q->f('type'),$q->f('item_id'),$q->f('item_label'),$q->f('operation'),$q->f('target_value'),$q->f('valuetype_label'), $q->f('poz'));
					}
                    return true;
                } else {
					Messages::addError("Erroare la crearea companiei <b>". $companie->name ."</b>");
				}
            }

            return false;
        }
		
		private static function registerCompanyCard($companyId,$type,$itemId,$itemLabel,$operation,$targetValue,$valueTypeLabel,$poz)
        {
            if (!empty($companyId)) {
				$card=new ValoriCard;
				$card->company_id = $companyId;
                $card->type = $type;
				$card->item_id = $itemId;
				$card->item_label = $itemLabel;
				$card->operation = $operation;
				$card->target_value = $targetValue;
				$card->valueType_label = $valueTypeLabel;
				$card->poz = $poz;
                $card->insert();
			}
		}
		
		public static function edit($post)
        {
            if (!empty($post['id']) &&!empty($post['name'])) {
			    $companie = new self;
                $companie = Companies::getUserCompany($post['id'], Users::getLogged()->id);
                $companie->name = $post['name'];
				$companie->cui = $post['companie_cui'];
				
				if($companie->isDemo==1) {
					Messages::addError("Erroare la editarea companiei <b>". $companie->name ."</b> Aceasta companie este o companie demonstrativa si nu poate fi editata");
					return false;
				}
				
                $companie->update();

                if ( !empty($companie->id) ) {
					Messages::addNotice("Datele companiei <b>". $companie->name ."</b> au fost salvate.");
                    return true;
                } else {
					Messages::addError("Eroare la salvarea datelor companiei <b>". $companie->name ."</b>");
					return false;
				}
            }
			Messages::addError("Eroare la salvarea datelor companiei <b>". $companie->name ."</b>. <br/> Numele companiei este obligatoriu.");
            return false;
        }
		public static function deleteCompany($post)
        {
            if (!empty($post['id'])) {
			    $companie = new self;
                $companie = Companies::getUserCompany($post['id'], Users::getLogged()->id);
				if($companie->isDemo==1) {
					Messages::addError("Erroare la stergerea companiei <b>". $companie->name ."</b> Aceasta companie este o companie demonstrativa si nu poate fi stearsa");
					return false;
				}
				
                if( $companie->delete()) {
					Messages::addNotice("Compania <b>". $companie->name ."</b> a fost stearsa.");
					return true;
				} else {
					Messages::addError("Erroare la stergerea companiei <b>". $companie->name ."</b>");
					return false;
				}
                
            }
			
            return false;
        }

	}