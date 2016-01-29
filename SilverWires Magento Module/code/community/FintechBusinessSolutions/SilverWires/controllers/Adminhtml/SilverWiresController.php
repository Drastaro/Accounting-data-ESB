<?php

class FintechBusinessSolutions_SilverWires_Adminhtml_SilverWiresController extends Mage_Adminhtml_Controller_action
{

	public function indexAction() {
		
		 $this->loadLayout();

        //create a text block with the name of "example-block"
        $block = $this->getLayout()
        ->createBlock('core/text', 'example-block')
        ->setText('<h1>SilverWires</h1><br/><p>Automated data connections</p><p>Your SilverWires Magento module is installed correctly.</p><p>To setup your data connections visit: <a href="http://www.silverwiresapp.com" traget="_blank">www.silverwiresapp.com</a></p> ');

        $this->_addContent($block);
		
		$this->_setActiveMenu('silverwires')
			->_addBreadcrumb(Mage::helper('adminhtml')->__('Items Manager'), Mage::helper('adminhtml')->__('Item Manager'));

        $this->renderLayout();
		
	
	}

	
}