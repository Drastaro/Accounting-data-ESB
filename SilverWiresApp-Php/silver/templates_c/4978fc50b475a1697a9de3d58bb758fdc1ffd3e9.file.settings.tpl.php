<?php /* Smarty version Smarty-3.0.6, created on 2015-10-20 17:34:57
         compiled from "C:\wamp\www\silver//templates/pages/magento/settings.tpl" */ ?>
<?php /*%%SmartyHeaderCode:499856265111a13137-80702985%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4978fc50b475a1697a9de3d58bb758fdc1ffd3e9' => 
    array (
      0 => 'C:\\wamp\\www\\silver//templates/pages/magento/settings.tpl',
      1 => 1445351647,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '499856265111a13137-80702985',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<!-- Content Header (Page header) -->
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
                  <h3 class="box-title">Magento access setup</h3>
                </div><!-- /.box-header -->

                <!-- form start -->
                <form role="form" method="post">
					<input type="hidden" name="mode" value="<?php echo $_smarty_tpl->getVariable('mode')->value;?>
">
					<input type="hidden" name="id" value="<?php echo $_smarty_tpl->getVariable('magentoData')->value->id;?>
">

                  <div class="box-body">
					<p>In order to access your Magento store we need a SOAP user with a valid password. You can create a new Soap user in Magento Admin -> System -> Web services -> SOAP/XML-RPC - Users  and then set the correct roles in Admin -> System -> Web services -> SOAP/XML-RPC - Roles<br/> The user must have the following rights:
						<ul>
							<li> Catalog -> Product ->Retrieve product data </li>
							<li> Catalog -> Product ->Custom options -> List </li>
							<li> Catalog -> Product ->Custom options -> Info </li>
							<li> Sales -> Order -> Order shipments -> Retrieve shipment info </li>
							<li> Sales -> Order -> Retrieve order info </li>
						</ul>
					<div class="form-group">
                      <label for="username">Magento store web address (URL e.g. www.mystore.com)</label>
                      <input type="text" class="form-control" name="mag_url" id="mag_url" placeholder="Enter Magento store url" value="<?php echo $_smarty_tpl->getVariable('magentoData')->value->url;?>
">
                    </div>
                    <div class="form-group">
                      <label for="username">Magento SOAP username</label>
                      <input type="text" class="form-control" name="mag_username" id="mag_username" placeholder="Enter Magento SOAP username" value="<?php echo $_smarty_tpl->getVariable('magentoData')->value->username;?>
">
                    </div>
                    <div class="form-group">
                      <label for="exampleInputPassword1">Magento SOAP password</label>
                      <input type="password" class="form-control" name="mag_pass" id="mag_pass" placeholder="Enter Magento SOAP password" value="">
                    </div>
                  </div><!-- /.box-body -->

                  <div class="box-footer">
					 
                    <button type="submit" class="btn btn-primary pull-right">Save</button>
					<a href="#" id="mgt_test_conn" class="btn btn-primary pull-right" style="margin-right:20px">Test connection</a>
                  </div>
                </form>
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
		

<script>

	$("#mgt_test_conn").click(function() {	
			$("#mgt_test_conn").prop('text', 'Testing...');
					$.post( "/magento_test_conn", { mag_url: $("#mag_url").val(), mag_username: $("#mag_username").val(), mag_pass: $("#mag_pass").val() })
					  .done(function( data ) {
						if(data=='true') {
							message = "Connection tested and is working properly. Save the data.";
						} else {
							message = "Connection with Magento could not be established. Re-enter data.";
						}
						alert( message );
						$("#mgt_test_conn").prop('text', 'Test connection');
					  });
				});		

</script>
		
