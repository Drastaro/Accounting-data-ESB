<?php

class FintechBusinessSolutions_SilverWires_Block_Adminhtml_SilverWires_Edit extends Mage_Adminhtml_Block_Widget_Form_Container
{
    public function __construct()
    {
        parent::__construct();
                 
        $this->_objectId = 'id';
        $this->_blockGroup = 'silverwires';
        $this->_controller = 'adminhtml_silverwires';
        
        $this->_updateButton('save', 'label', Mage::helper('silverwires')->__('Save Item'));
        $this->_updateButton('delete', 'label', Mage::helper('silverwires')->__('Delete Item'));
		
        $this->_addButton('saveandcontinue', array(
            'label'     => Mage::helper('adminhtml')->__('Save And Continue Edit'),
            'onclick'   => 'saveAndContinueEdit()',
            'class'     => 'save',
        ), -100);

        $this->_formScripts[] = "
            function toggleEditor() {
                if (tinyMCE.getInstanceById('silverwires_content') == null) {
                    tinyMCE.execCommand('mceAddControl', false, 'silverwires_content');
                } else {
                    tinyMCE.execCommand('mceRemoveControl', false, 'silverwires_content');
                }
            }

            function saveAndContinueEdit(){
                editForm.submit($('edit_form').action+'back/edit/');
            }
        ";
    }

    public function getHeaderText()
    {
        if( Mage::registry('silverwires_data') && Mage::registry('silverwires_data')->getId() ) {
            return Mage::helper('silverwires')->__("Edit Item '%s'", $this->htmlEscape(Mage::registry('silverwires_data')->getTitle()));
        } else {
            return Mage::helper('silverwires')->__('Add Item');
        }
    }
}