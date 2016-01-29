<?php /* Smarty version Smarty-3.0.6, created on 2015-10-07 18:42:42
         compiled from "C:\wamp\www\silver//templates/pages/magento_quickbooks/setup_quickbooks.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2706956153d726f02f8-94734172%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '8ee980c12f14e8cac39eb50a4de0e9cc32dd8a1b' => 
    array (
      0 => 'C:\\wamp\\www\\silver//templates/pages/magento_quickbooks/setup_quickbooks.tpl',
      1 => 1444232546,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2706956153d726f02f8-94734172',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_function_html_options')) include 'C:\wamp\www\silver\include\lib\smarty\plugins\function.html_options.php';
?> <script type="text/javascript" src="https://appcenter.intuit.com/Content/IA/intuit.ipp.anywhere.js"></script>
 
  <script>
    // Runnable uses dynamic URLs so we need to detect our current //
    // URL to set the grantUrl value   ########################### //
    /*######*/ var parser = document.createElement('a');/*#########*/
    /*######*/parser.href = document.url;/*########################*/
    // end runnable specific code snipit ##########################//
    var x=intuit.ipp.anywhere.setup({
        menuProxy: '',
        grantUrl: '<?php echo $_smarty_tpl->getVariable('sw_AdminURL')->value;?>
/quickbooks/auth/requestToken?sw_user_id=<?php echo $_smarty_tpl->getVariable('sw_user_id')->value;?>
' 
        // outside runnable you can point directly to the oauth.php page
    });
  </script>
  

<div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Quickbooks setup</h3>
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
								<?php if ($_smarty_tpl->getVariable('taxesMapping')->value[$_smarty_tpl->tpl_vars['k']->value]){?>
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
					<button type="button" id="disconnect-button" class="btn btn-warning pull-left">Disconnect QuickBooks</button>
                    <button type="submit" class="btn btn-primary pull-right">Save</button>
                  </div>
                </form>
				<?php }else{ ?>
				
					<p>In order to send data to you Quickbooks account we need you to authorize our Quickbooks application for your account.</p>
					<p><ipp:connectToIntuit></ipp:connectToIntuit><br /></p>
				<?php }?>	
				</div>
				</div>
				

<script>

	$("#disconnect-button").click(function() {	
		$("#form-action").val("disconnect-qb");
		$("#qb-form").submit();
			
	});

</script>
	