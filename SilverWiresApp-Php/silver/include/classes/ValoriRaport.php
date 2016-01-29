<?php
class ValoriRaport extends BaseObject
{
    public
        $id,
        $balantaId,
        $tableReportItemId,
        $tableReportItemLabel,
        $tableReportItemValue,
		$tableReportItemValueCumulated,
		$valuePercent,
		$valueCumulatedPercent,
		$valueType_label,
		$isKPI;

    public function getTableName()
    {
        return 'balanta_reportitems';
    }

    public function getFields()
    {
        return array ( 'id', 'balantaId', 'tableReportItemId', 'tableReportItemLabel', 'tableReportItemValue', 'tableReportItemValueCumulated', 'valuePercent', 'valueCumulatedPercent', 'valueType_label', 'isKPI' );
    }

    public function getList($append)
    {

        $ret = array();
        $fields = "`{$this->getTableName()}`.`" . implode("`, `{$this->getTableName()}`.`", $this->getFields()). "`";

        $query =  " SELECT $fields FROM " . $this->getTableName(). " " . $append;
		
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
	
	public function value() 
	{
		return ($this->tableReportItemValue!=null)? $this->tableReportItemValue:0;
	}
	
	public function valueCumulated() 
	{
		return ($this->tableReportItemValueCumulated!=null)? $this->tableReportItemValueCumulated:0;
	}
	
	public function valuePercent() 
	{
		return ($this->valuePercent!=null)? $this->valuePercent:0;
	}
	
	public function valueCumulatedPercent() 
	{
		return ($this->valueCumulatedPercent!=null)? $this->valueCumulatedPercent:0;
	}
	
	public function itemLabelUPPER() {
		return strtoupper($this->tableReportItemLabel);
	}
	
	public function valueTypeLabel() {
		return TXT::$LABELS[$this->valueType_label];
	}
	
	public function isKPI() {
		return $this->isKPI;
	}
	
	

    public static function retrieveValoriRaportByBalantaId($balantaId)
    {
		$result=array();
        $self = new self;
		$listValori = $self->getList( "WHERE `balantaId`=" . intval($balantaId));
		
		foreach($listValori as $val) {
		    $result[strtoupper($val->tableReportItemLabel)] = $val ;   
		}
        return $result;
    }

   

}