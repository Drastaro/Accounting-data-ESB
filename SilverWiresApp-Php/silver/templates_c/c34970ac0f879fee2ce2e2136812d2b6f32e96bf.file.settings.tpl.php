<?php /* Smarty version Smarty-3.0.6, created on 2015-10-23 09:50:58
         compiled from "C:\wamp\www\silver//templates/pages/quickbooks/settings.tpl" */ ?>
<?php /*%%SmartyHeaderCode:213435629d8d2d88e07-77875371%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c34970ac0f879fee2ce2e2136812d2b6f32e96bf' => 
    array (
      0 => 'C:\\wamp\\www\\silver//templates/pages/quickbooks/settings.tpl',
      1 => 1445583046,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '213435629d8d2d88e07-77875371',
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
           
			
			 <div class="col-md-7">
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
                    
                     
                  </div><!-- /.box-body -->

                  <div class="box-footer">
					<button type="button" id="disconnect-button" class="btn btn-warning pull-left">Disconnect QuickBooks</button>
                   
                  </div>
                </form>
				<?php }else{ ?>
				
					<p>In order to send data to your Quickbooks account we need you to authorize our Quickbooks application for your account.</p>
					<p><ipp:connectToIntuit></ipp:connectToIntuit><br /></p>
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
 <script type="text/javascript" src="https://appcenter.intuit.com/Content/IA/intuit.ipp.anywhere.js"></script>
 
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
  
		

<script>

	$("#disconnect-button").click(function() {	
		$("#form-action").val("disconnect-qb");
		$("#qb-form").submit();
			
	});

</script>
	