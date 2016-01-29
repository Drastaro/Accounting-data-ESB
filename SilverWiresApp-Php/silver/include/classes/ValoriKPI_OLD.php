<?php
class ValoriKPI_OLD extends BaseObject
{
    public
        $id,
        $balantaId,
        $kpiId,
        $kpiLabel,
        $kpiValue,
		$kpiValueCumulated;
		
    public function getTableName()
    {
        return 'balanta_kpi';
    }

    public function getFields()
    {
        return array ( 'id', 'balantaId', 'kpiId', 'kpiLabel', 'kpiValue', 'kpiValueCumulated');
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
		return ($this->kpiValue!=null)? $this->kpiValue:0;
	}
	
	public function valueCumulated() 
	{
		return ($this->kpiValueCumulated!=null)? $this->kpiValueCumulated:0;
	}
	
	

    public static function retrieveValoriKPIByBalantaId($balantaId)
    {
		$result=array();
        $self = new self;
		$listValori = $self->getList( "WHERE `balantaId`=" . intval($balantaId));
		
		foreach($listValori as $val) {
		    $result[strtoupper($val->kpiLabel)] = $val ;   
		}
        return $result;
    }

   

}