<?php
class FintechBusinessSolutions_SilverWires_Block_SilverWires extends Mage_Core_Block_Template
{
	public function _prepareLayout()
    {
		return parent::_prepareLayout();
    }
    
     public function getSilverWires()     
     { 
        if (!$this->hasData('silverwires')) {
            $this->setData('silverwires', Mage::registry('silverwires'));
        }
        return $this->getData('silverwires');
        
    }
}