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
			{if $areMessages==true}
				<div class="callout {$messageClass}">
                    <p>{$pageMessages}</p>
                  </div>
				{/if}
			</div>
		  </div>
          <div class="row">
           
			
			 <div class="col-md-7">
				<div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Quickbooks setup</h3>
                </div><!-- /.box-header -->
				<div class="box-body">
				{if $quickbooksStatus == 'connected'}
					Your Quickbooks account is connected and ready to use. <br/>
					<!-- form start -->
                <form role="form" method="post" id="qb-form">
					<input type="hidden" name="mode" id="form-action" value="save-qb">
					

                  <div class="box-body">
					
					<div class="form-group">
                      <label for="CompanyName">Your Quickbooks account company name</label>
                      <input type="text" class="form-control" name="company_name" id="company_name" value="{$companyName}" readonly=true>
                    </div>
                    
                     
                  </div><!-- /.box-body -->

                  <div class="box-footer">
					<button type="button" id="disconnect-button" class="btn btn-warning pull-left">Disconnect QuickBooks</button>
                   
                  </div>
                </form>
				{else}
				
					<p>In order to send data to your Quickbooks account we need you to authorize our Quickbooks application for your account.</p>
					<p><ipp:connectToIntuit></ipp:connectToIntuit><br /></p>
				{/if}	
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
 {literal}
  <script>
    // Runnable uses dynamic URLs so we need to detect our current //
    // URL to set the grantUrl value   ########################### //
    /*######*/ var parser = document.createElement('a');/*#########*/
    /*######*/parser.href = document.url;/*########################*/
    // end runnable specific code snipit ##########################//
    var x=intuit.ipp.anywhere.setup({
        menuProxy: '',
        grantUrl: '{/literal}{$sw_AdminURL}{literal}/quickbooks/auth/requestToken?sw_user_id={/literal}{$sw_user_id}{literal}' 
        // outside runnable you can point directly to the oauth.php page
    });
  </script>
  {/literal}
		
{literal}
<script>

	$("#disconnect-button").click(function() {	
		$("#form-action").val("disconnect-qb");
		$("#qb-form").submit();
			
	});

</script>
{/literal}	