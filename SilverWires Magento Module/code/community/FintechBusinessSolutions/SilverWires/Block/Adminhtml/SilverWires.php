<?php
class FintechBusinessSolutions_SilverWires_Block_Adminhtml_SilverWires extends Mage_Adminhtml_Block_Widget_Grid_Container
{
  public function __construct()
  {
    $this->_controller = 'adminhtml_silverwires';
    $this->_blockGroup = 'silverwires';
    $this->_headerText = Mage::helper('silverwires')->__('Item Manager');
    $this->_addButtonLabel = Mage::helper('silverwires')->__('Add Item');
    parent::__construct();
  }
}