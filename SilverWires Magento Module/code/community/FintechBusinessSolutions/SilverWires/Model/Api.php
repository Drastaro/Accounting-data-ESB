<?php
class FintechBusinessSolutions_SilverWires_Model_Api extends Mage_Api_Model_Resource_Abstract
{        
		public function swListTaxes()
        {
		/*$productClasses = Mage::getModel('tax/class')
            ->getCollection()
            ->setClassTypeFilter(Mage_Tax_Model_Class::TAX_CLASS_TYPE_PRODUCT)
            ->toOptionArray(); 
			$taxCalculationModel = Mage::getModel('tax/class')->getCollection();*/
			
			 $rateCollection = Mage::getModel('tax/calculation_rate')->getCollection() ->toOptionArray();
           
			
			return json_encode($rateCollection);
		
        }
}