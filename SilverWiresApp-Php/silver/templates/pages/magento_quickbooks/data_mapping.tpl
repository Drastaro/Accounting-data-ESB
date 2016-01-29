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
            <!-- left column -->
            <div class="col-md-7">
				<div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Magento - Quickbooks data mapping</h3>
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
								{if  $taxesMapping|is_array && array_key_exists($k, $taxesMapping)}
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
                    <button type="submit" class="btn btn-primary pull-right">Save</button>
                  </div>
                </form>
				{else}
				
					<p>In order to send data to you Quickbooks account we need you to authorize our Quickbooks application for your account.</p>
					<p>Use the QuickBooks settings page in order to connect to your QuickBooks account<br /></p>
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
		
