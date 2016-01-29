<?php /* Smarty version Smarty-3.0.6, created on 2015-10-21 01:06:41
         compiled from "C:\wamp\www\silver//templates/pages/magento_quickbooks/log.tpl" */ ?>
<?php /*%%SmartyHeaderCode:81455626baf1cfe1d1-56181837%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'f6fccbcaa4ee051c1a0c7c4402b4d62bada055cf' => 
    array (
      0 => 'C:\\wamp\\www\\silver//templates/pages/magento_quickbooks/log.tpl',
      1 => 1445378800,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '81455626baf1cfe1d1-56181837',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<section class="content-header">
          <h1>
            Magento - QuickBooks sync log
            <small></small>
          </h1>
		  
        </section>
		
		
		<section class="content">
          <div class="row">
			
            <!-- left column -->
            <div class="col-md-7">

				<div class="box box-primary">
                

                

                  <div class="box-body">
					<ul class="timeline timeline-inverse">
                      <!-- timeline time label -->
                      <li class="time-label">
                        <span class="bg-blue">
                          20 Oct 2015
                        </span>
                      </li>
                      <!-- /.timeline-label -->
                      <!-- timeline item -->
                      <li>
                        <i class="fa fa-envelope bg-gray"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="fa fa-clock-o"></i> 00:02</span>
                          <div class="timeline-body">3 orders transfered from Magento to QuickBooks</div>
                      
                        </div>
                      </li>
					  <li>
                        <i class="fa fa-envelope bg-gray"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="fa fa-clock-o"></i> 00:02</span>
                          <div class="timeline-body">2 new Magento customers created into Quickbooks</div>
                      
                        </div>
                      </li>
					  <li>
                        <i class="fa fa-envelope bg-gray"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="fa fa-clock-o"></i> 00:02</span>
                          <div class="timeline-body">0 products transfered from Magento into QuickBooks</div>
                      
                        </div>
                      </li>
                      
                      <!-- timeline time label -->
                      <!-- timeline time label -->
                      <li class="time-label">
                        <span class="bg-blue">
                          10 Oct 2015
                        </span>
                      </li>
                      <!-- /.timeline-label -->
                      <!-- timeline item -->
                      <li>
                        <i class="fa fa-envelope bg-gray"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="fa fa-clock-o"></i> 00:02</span>
                          <div class="timeline-body">5 orders transfered from Magento to QuickBooks</div>
                      
                        </div>
                      </li>
					  <li>
                        <i class="fa fa-envelope bg-gray"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="fa fa-clock-o"></i> 00:02</span>
                          <div class="timeline-body">3 new Magento customers created into Quickbooks</div>
                      
                        </div>
                      </li>
					  <li>
                        <i class="fa fa-envelope bg-gray"></i>
                        <div class="timeline-item">
                          <span class="time"><i class="fa fa-clock-o"></i> 00:02</span>
                          <div class="timeline-body">3 products transfered from Magento into QuickBooks</div>
                      
                        </div>
                      </li>
                    </ul>
					
                  </div><!-- /.box-body -->

                  
              </div>
		</div>
		
		<div class="col-md-5">
			 <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Wire details</h3>
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
