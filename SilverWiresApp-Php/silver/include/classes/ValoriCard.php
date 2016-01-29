<?php
class ValoriCard extends BaseObject
{
    public
        $id,
        $company_id,
		/*  type values:
				0 - crestere/reducere lunara
				1 - valoare lunara
				2 - valoare pondere lunara din total venituri
				3 - crestere/reducere pondere lunara din total venituri
				4 - valoare indicatori financiari
		*/
        $type, 
        $item_id,
        $item_label,
		/* operation values:
				0 - crestre
				1 - scadere
				2 - minim
				3 - maxim
		*/
		$operation,
		$target_value,
		$valueType_label,
		$poz;
		
    public function getTableName()
    {
        return 'card_items';
    }

    public function getFields()
    {
        return array ( 'id', 'company_id', 'type', 'item_id', 'item_label', 'operation', 'target_value', "valueType_label", "poz");
    }

    public function getList($append)
    {

        $ret = array();
        $fields = "`{$this->getTableName()}`.`" . implode("`, `{$this->getTableName()}`.`", $this->getFields()). "`";

        $query =  " SELECT $fields FROM " . $this->getTableName(). " " . $append." order by poz";		
		//echo $query;

        $q = new DbMySql($query, $this->getDatabase());
        $className = get_class($this);
        while ($q->nextRecord()) {
            $obj = new $className;
            $obj->setRecord($q->getRecord());
            $ret[$obj->id] = $obj;
        }

        return $ret;
    }
	
	public function objectiveText() 
	{	
		$templateType0="Indicatorul <b>#label</b> sa #operation cu #targetvalue#valueSign fata de luna precedenta.";
		$templateType1="Indicatorul <b>#label</b> sa fie #operation <span class='money_top'>#targetvalue</span>#valueSign.";
		$templateType2="Valoarea ponderii lunare al indicatorului <b>#label</b> sa fie #operation #targetvalue#valueSign din total venituri.";
		
		$result= "";
				
		$label=TXT::$TXT_RAPORT[strtoupper($this->item_label)];
		$valueSign = TXT::$LABELS['percent'];
		$operation ="err";
		switch ($this->operation) {
			case 0:
				$operation="creasca";
				break;
			case 1:
				$operation="scada";
				break;
			case 2:
				$operation="minim";
				break;
			case 3:
				$operation="maxim";
				break;
		}
		
		switch ($this->type) {
			case 0:	
				$templateType=$templateType0;
				break;
			case 1:
				$valueSign = TXT::$LABELS[$this->valueType_label];
				$templateType=$templateType1;
				break;
			case 2:
				$templateType=$templateType2;
				break;			
		}
		$result=str_replace("#label",strtolower($label),$templateType);
		$result=str_replace("#operation",$operation,$result);
		$result=str_replace("#targetvalue",$this->target_value,$result);
		$result=str_replace("#valueSign",$valueSign,$result);
		
		return $result;
		
	}
	
	public function itemLabel() {
		return TXT::$TXT_RAPORT[strtoupper($this->item_label)];
	}
	
	public function reportValue($valoriRaportLunar) 
	{
		$val=$valoriRaportLunar[strtoupper($this->item_label)]->value();
		$valueSign=TXT::$LABELS[$this->valueType_label];		
		return "<span class='money_top'>".$val."</span>"."<small>".$valueSign."</small>";		
	}
	
	public function reportValuePercent($valoriRaportLunar) 
	{
		$val=$valoriRaportLunar[strtoupper($this->item_label)]->valuePercent();
		$valueSign=TXT::$LABELS['percent'];		
		return $val."<small>".$valueSign."</small>";		
	}
	
	public function realizationPercent($valoriRaportLunar, $valoriRaportPrecedent) {
		$val=$valoriRaportLunar[strtoupper($this->item_label)]->value();
		$valPrecedent=$valoriRaportPrecedent[strtoupper($this->item_label)]->value();
				
		
		switch ($this->type) {
			case 0:
				if($this->operation==0) {
					//crestere
					if($valPrecedent>$val) {
						$percent=0;
					} else {
						$targetVal=$valPrecedent+($valPrecedent*($this->target_value/100));					
						if($targetVal==0) $targetVal=1;
						$percent=$val/$targetVal*100;
					}	
				} else {
					//scadere
					if($valPrecedent<$val) {
						$percent=0;
					} else {
						$targetVal=$valPrecedent*(100-$this->target_value);
						if($val==0) $val=1;
						$percent=$targetVal/$val;
					}
				}
				if($percent>100)
					$percent=100;
				if($percent<0)
					$percent=0;
				break;
			case 1:
			    if($this->operation==2) {							
					$percent=$val*100/$this->target_value;					
				} else {
					if($val==0) $val=1;
					$percent=$this->target_value/$val*100;
				}
				if($percent>100)
					$percent=100;
				if($percent<0)
					$percent=0;
				break;
			case 2:
				$val=$valoriRaportLunar[strtoupper($this->item_label)]->valuePercent();
				$valPrecedent=$valoriRaportPrecedent[strtoupper($this->item_label)]->valuePercent();
				if($this->operation==2) {
					if($valPrecedent==0) {
						$valPrecedent=1;
					}				
					$percent=$val*100/$this->target_value;				
					
				} else {
					if($val==0) $val=1;
					$percent=$this->target_value/$val*100;
				}
				if($percent>100)
					$percent=100;
				if($percent<0)
					$percent=0;
				break;
		}
		return abs(round($percent,0));
	}
	
	public function trendDirection($valoriRaportLunar, $valoriRaportPrecedent) {
		$val=$valoriRaportLunar[strtoupper($this->item_label)]->value();
		$valPrecedent=$valoriRaportPrecedent[strtoupper($this->item_label)]->value();
		
		if($valPrecedent>$val) {
			return -1;
		} else if($valPrecedent==$val) {
				return 0;
			} else {
				return 1;
			}
	}
	
	public function trendPercent($valoriRaportLunar, $valoriRaportPrecedent) {
		$val=$valoriRaportLunar[strtoupper($this->item_label)]->value();
		$valPrecedent=$valoriRaportPrecedent[strtoupper($this->item_label)]->value();
				
		
		switch ($this->type) {
			case 0:				
				if($valPrecedent==0) {
					$valPrecedent=1;
					$monthDifference=$val;
				} else {
					$monthDifference=$valPrecedent-$val;
				}				
				$percent=$monthDifference*100/$valPrecedent;				
				break;
			case 1:
				if($valPrecedent==0) {
					$valPrecedent=1;
					$monthDifference=$val;
				} else {
					$monthDifference=$valPrecedent-$val;
				}				
				$percent=$monthDifference*100/$valPrecedent;				
				break;
			case 2:
				$val=$valoriRaportLunar[strtoupper($this->item_label)]->valuePercent();
				$valPrecedent=$valoriRaportPrecedent[strtoupper($this->item_label)]->valuePercent();
				if($valPrecedent==0) {
					$valPrecedent=1;
					$monthDifference=$val;
				} else {
					$monthDifference=$valPrecedent-$val;
				}				
				$percent=$monthDifference*100/$valPrecedent;				
				break;			
		}
		return abs(round($percent,0));
	}
	
	public function status($valoriRaportLunar, $valoriRaportPrecedent) {		
		
		if($this->realizationPercent($valoriRaportLunar, $valoriRaportPrecedent)>=100) {
			return 1;
		} else {
			return -1;
		}
	}
	

    public static function retrieveCardsByCompany($company)
    {
        $self = new self;
		if($company->user_id==Users::getLogged()->id) {
			return $self->getList( "WHERE `company_id`=" . $company->id);
		} else {
			return array();
		}
    }
	
	private static function getCard($cardId)
    {
			$ret = new ValoriCard();
			$self= new self;
            $fields = "`{$self->getTableName()}`.`" . implode("`, `{$self->getTableName()}`.`", $self->getFields()). "` ";

            $query =  " SELECT $fields FROM " . $self->getTableName(). " WHERE `id`=".$cardId;

            $q = new DbMySql($query, $self->getDatabase());
            $className = get_class($self);
            while ($q->nextRecord()) {
                $obj = new $className;
                $obj->setRecord($q->getRecord());
                $ret = $obj;
            }

            return $ret;
    }
	
	 public static function edit($post)
        {			
            if (!empty($post['id'])) {
				$company =  Companies::getUserCompanyById( $post['cid'], Users::getLogged()->id );
				if($company==null) 
					return false;
								    
                $card = ValoriCard::getCard($post['id']);
                $card->type = $post['type'];
				$card->item_id = $post['item'];
				$card->item_label = $post['item_label'];
				$card->operation = $post['operation'];
				$card->target_value = $post['target_value'];
				$card->valueType_label = $post['valueType_label'];
				
                $card->update();

                if ( !empty($card->id) ) {
					Messages::addNotice("Obiectivul a fost salvat cu succes.");
                    return true;
                } else {
					Messages::addError("Eroare la salvarea obiectivului - Obiectivul nu a putut fi salvat");
					return false;
				}
            }
			Messages::addError("Eroare la salvarea obiectivului - Datele sunt incorecte");
            return false;
        }
		
		 


}