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
			  {if $areMessages==true}
				<div class="callout {$messageClass}">
                    <p>{$pageMessages}</p>
                  </div>
				{/if}
			</div>
		  </div>
          <div class="row">
            <!-- left column -->
            <div class="col-md-6">
				<div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Magento access setup</h3>
                </div><!-- /.box-header -->

                <!-- form start -->
                <form role="form" method="post">
					<input type="hidden" name="mode" value="{$mode}">
					<input type="hidden" name="id" value="{$magentoData->id}">

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
                      <input type="text" class="form-control" name="mag_url" id="mag_url" placeholder="Enter Magento store url" value="{$magentoData->url}">
                    </div>
                    <div class="form-group">
                      <label for="username">Magento SOAP username</label>
                      <input type="text" class="form-control" name="mag_username" id="mag_username" placeholder="Enter Magento SOAP username" value="{$magentoData->username}">
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
			
			 <div class="col-md-6">
				{include file="pages/magento_quickbooks/setup_quickbooks.tpl"}  
				
			</div>
			
			
			
		</div>
		</section>
		
{literal}
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
{/literal}		
