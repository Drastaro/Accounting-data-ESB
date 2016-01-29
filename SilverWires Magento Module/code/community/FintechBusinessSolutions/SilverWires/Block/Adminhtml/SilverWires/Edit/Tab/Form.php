<?php

class FintechBusinessSolutions_SilverWires_Block_Adminhtml_SilverWires_Edit_Tab_Form extends Mage_Adminhtml_Block_Widget_Form
{
  protected function _prepareForm()
  {
      $form = new Varien_Data_Form();
      $this->setForm($form);
      $fieldset = $form->addFieldset('silverwires_form', array('legend'=>Mage::helper('silverwires')->__('Item information')));
     
      $fieldset->addField('title', 'text', array(
          'label'     => Mage::helper('silverwires')->__('Title'),
          'class'     => 'required-entry',
          'required'  => true,
          'name'      => 'title',
      ));

      $fieldset->addField('filename', 'file', array(
          'label'     => Mage::helper('silverwires')->__('File'),
          'required'  => false,
          'name'      => 'filename',
	  ));
		
      $fieldset->addField('status', 'select', array(
          'label'     => Mage::helper('silverwires')->__('Status'),
          'name'      => 'status',
          'values'    => array(
              array(
                  'value'     => 1,
                  'label'     => Mage::helper('silverwires')->__('Enabled'),
              ),

              array(
                  'value'     => 2,
                  'label'     => Mage::helper('silverwires')->__('Disabled'),
              ),
          ),
      ));
     
      $fieldset->addField('content', 'editor', array(
          'name'      => 'content',
          'label'     => Mage::helper('silverwires')->__('Content'),
          'title'     => Mage::helper('silverwires')->__('Content'),
          'style'     => 'width:700px; height:500px;',
          'wysiwyg'   => false,
          'required'  => true,
      ));
     
      if ( Mage::getSingleton('adminhtml/session')->getSilverWiresData() )
      {
          $form->setValues(Mage::getSingleton('adminhtml/session')->getSilverWiresData());
          Mage::getSingleton('adminhtml/session')->setSilverWiresData(null);
      } elseif ( Mage::registry('silverwires_data') ) {
          $form->setValues(Mage::registry('silverwires_data')->getData());
      }
      return parent::_prepareForm();
  }
}