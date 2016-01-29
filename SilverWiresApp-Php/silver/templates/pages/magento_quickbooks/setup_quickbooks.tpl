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
                    <div class="form-group">
                      <label for="incomeAccount">Default income account for items imported into Quickbooks</label>
                      {html_options name=accountsOp options=$incomeAccounts name="incomeAccount" id="incomeAccount" class="form-control" selected=$selectedIncomeAccountId}
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
					 {foreach from=$magentoTaxes key=k item=v}
						<div class="form-group">
							<div class="row">
							<div class="col-md-5">
								<b><select readonly class="form-control" name="taxes[{$k}][mag]"><option value="{$k}">{$v}</option></select></b>
							</div>
							<div class="col-md-2" style="text-align:center">
								map to
							</div>
							<div class="col-md-5">
								{if $taxesMapping[$k]}
									{assign var="selectedQbTaxId" value=$taxesMapping[$k]}
								{else}
									{assign var="selectedQbTaxId" value="-1"}
								{/if}
								<b>{html_options name=taxesOp options=$qbTaxes name="taxes[$k][qb]" id="tax" class="form-control" selected=$selectedQbTaxId}</b>
							</div>
							</div>
						 </div>	
					{/foreach}
                    
                    </div>
                  </div><!-- /.box-body -->

                  <div class="box-footer">
					<button type="button" id="disconnect-button" class="btn btn-warning pull-left">Disconnect QuickBooks</button>
                    <button type="submit" class="btn btn-primary pull-right">Save</button>
                  </div>
                </form>
				{else}
				
					<p>In order to send data to you Quickbooks account we need you to authorize our Quickbooks application for your account.</p>
					<p><ipp:connectToIntuit></ipp:connectToIntuit><br /></p>
				{/if}	
				</div>
				</div>
				
{literal}
<script>

	$("#disconnect-button").click(function() {	
		$("#form-action").val("disconnect-qb");
		$("#qb-form").submit();
			
	});

</script>
{/literal}	