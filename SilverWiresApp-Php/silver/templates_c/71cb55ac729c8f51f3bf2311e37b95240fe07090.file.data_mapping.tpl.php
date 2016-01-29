<?php /* Smarty version Smarty-3.0.6, created on 2015-10-29 10:57:59
         compiled from "D:\wamp\www\silver//templates/pages/magento_quickbooks/data_mapping.tpl" */ ?>
<?php /*%%SmartyHeaderCode:273125631df97983157-11518147%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '71cb55ac729c8f51f3bf2311e37b95240fe07090' => 
    array (
      0 => 'D:\\wamp\\www\\silver//templates/pages/magento_quickbooks/data_mapping.tpl',
      1 => 1446109070,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '273125631df97983157-11518147',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_function_html_options')) include 'D:\wamp\www\silver\include\lib\smarty\plugins\function.html_options.php';
?><!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Magento - Quickbooks WIRE
            <small>Setup</small>
          </h1>
		  
        </section>
		
		
		<section class="content">
		  <div class="row">
			<div class="col-md-12">
			
			  <?php if ($_smarty_tpl->getVariable('areMessages')->value==true){?>
				<div class="callout <?php echo $_smarty_tpl->getVariable('messageClass')->value;?>
">
                    <p><?php echo $_smarty_tpl->getVariable('pageMessages')->value;?>
</p>
                  </div>
				<?php }?>
			</div>
		  </div>
          <div class="row">
            <!-- left column -->
            <div class="col-md-7">
				<div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Magento - Quickbooks data mapping</h3>
                </div><!-- /.box-header -->
				<div class="box-body">
				<?php if ($_smarty_tpl->getVariable('quickbooksStatus')->value=='connected'){?>
					Your Quickbooks account is connected and ready to use. <br/>
					<!-- form start -->
                <form role="form" method="post" id="qb-form">
					<input type="hidden" name="mode" id="form-action" value="save-qb">
					

                  <div class="box-body">
					
					<div class="form-group">
                      <label for="CompanyName">Your Quickbooks account company name</label>
                      <input type="text" class="form-control" name="company_name" id="company_name" value="<?php echo $_smarty_tpl->getVariable('companyName')->value;?>
" readonly=true>
                    </div>
                    <div class="form-group">
                      <label for="incomeAccount">Default income account for items imported into Quickbooks</label>
                      <?php echo smarty_function_html_options(array('name'=>"incomeAccount",'options'=>$_smarty_tpl->getVariable('incomeAccounts')->value,'id'=>"incomeAccount",'class'=>"form-control",'selected'=>$_smarty_tpl->getVariable('selectedIncomeAccountId')->value),$_smarty_tpl);?>

                    </div>
                     <div class="form-group">
					 <label>Map Magento taxes to QuickBook taxes</label>
					 <div class="row">
						<div class="col-md-6" style="text-align:center">
							<b>Magento tax rate</b>
						</div>
						<div class="col-md-6" style="text-align:center">
							<b>QuickBooks Tax</b>
						</div>
					 </div>	
					 <?php  $_smarty_tpl->tpl_vars['v'] = new Smarty_Variable;
 $_smarty_tpl->tpl_vars['k'] = new Smarty_Variable;
 $_from = $_smarty_tpl->getVariable('magentoTaxes')->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
if ($_smarty_tpl->_count($_from) > 0){
    foreach ($_from as $_smarty_tpl->tpl_vars['v']->key => $_smarty_tpl->tpl_vars['v']->value){
 $_smarty_tpl->tpl_vars['k']->value = $_smarty_tpl->tpl_vars['v']->key;
?>
						<div class="form-group">
							<div class="row">
							<div class="col-md-5">
								<b><select readonly class="form-control" name="taxes[<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
][mag]"><option value="<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['v']->value;?>
</option></select></b>
							</div>
							<div class="col-md-2" style="text-align:center">
								map to
							</div>
							<div class="col-md-5">
								<?php if (is_array($_smarty_tpl->getVariable('taxesMapping')->value)&&array_key_exists($_smarty_tpl->tpl_vars['k']->value,$_smarty_tpl->getVariable('taxesMapping')->value)){?>
									<?php $_smarty_tpl->tpl_vars["selectedQbTaxId"] = new Smarty_variable($_smarty_tpl->getVariable('taxesMapping')->value[$_smarty_tpl->tpl_vars['k']->value], null, null);?>
								<?php }else{ ?>
									<?php $_smarty_tpl->tpl_vars["selectedQbTaxId"] = new Smarty_variable("-1", null, null);?>
								<?php }?>
								<b><?php echo smarty_function_html_options(array('name'=>"taxes[".($_smarty_tpl->tpl_vars['k']->value)."][qb]",'options'=>$_smarty_tpl->getVariable('qbTaxes')->value,'id'=>"tax",'class'=>"form-control",'selected'=>$_smarty_tpl->getVariable('selectedQbTaxId')->value),$_smarty_tpl);?>
</b>
							</div>
							</div>
						 </div>	
					<?php }} ?>
                    
                    </div>
                  </div><!-- /.box-body -->

                  <div class="box-footer">
                    <button type="submit" class="btn btn-primary pull-right">Save</button>
                  </div>
                </form>
				<?php }else{ ?>
				
					<p>In order to send data to you Quickbooks account we need you to authorize our Quickbooks application for your account.</p>
					<p>Use the QuickBooks settings page in order to connect to your QuickBooks account<br /></p>
				<?php }?>	
				</div>
				</div>
			</div>
			
			 <div class="col-md-5">
			 <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Setup</h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                  
                  <p>
                    The Magento - Quickbooks WIRE will automatically sync the Magento and Quickbooks by transforming every new Magento order into a Quickbooks invoice. 
                  </p>
				  <p>
					The following actions will be made automatically by the WIRE:
					<ul>
						<li>All Magento products will be imported into Quickbooks</li>
						<li>Every time a Magento Order is created it will be imported in Quickbooks as an Invoice</li>
						<li>If the Magento customer is not in Quickbooks it will be created</li>
						<li>For each order the shipping will be put as an invoice line in Quickbooks</li>
						<li>For each order the tax will be applied in the Quickbooks invoice</li>
						
					</ul>
				  </p>

                
                </div><!-- /.box-body -->
              </div>
				
				
			</div>
			
			
			
		</div>
		</section>
		
