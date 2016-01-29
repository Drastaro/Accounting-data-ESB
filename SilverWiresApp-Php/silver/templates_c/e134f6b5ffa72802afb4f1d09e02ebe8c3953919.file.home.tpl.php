<?php /* Smarty version Smarty-3.0.6, created on 2015-10-27 14:36:35
         compiled from "D:\wamp\www\silver//templates/pages/home.tpl" */ ?>
<?php /*%%SmartyHeaderCode:28256562f6fd3d52785-07565864%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e134f6b5ffa72802afb4f1d09e02ebe8c3953919' => 
    array (
      0 => 'D:\\wamp\\www\\silver//templates/pages/home.tpl',
      1 => 1445374900,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '28256562f6fd3d52785-07565864',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            SilverWires
            <small>Dashboard</small>
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
            <div class="col-md-12">
				<div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Welcome</h3>
                </div><!-- /.box-header -->

                

                  <div class="box-body">
					<p>SilverWires is the ultimate synchronisation tool for applications that generate invoices.</p>
					<p>	The application is powered by an Enterprise Service Bus that is capable of loging into system APIs and pull from there the relevant data for invoices, customers and services or products. The data is parsed and transformed and then is pushed towards the main accounting systems used: Intuit QuickBooks, Xero or SASSU. 
					</p>
					<p>
						As a SilverWires user you are able to define the login credentials for both you source and destination systems and define the data apping for the synchronization.
					</p>	
					
					<p>
						The data synchronization is done every day at midnight and you can see the log of each operation.
					</p>
					
                  </div><!-- /.box-body -->

                  
              </div>
			</div>
			
			<div class="col-md-6">
			  <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Magento - Quickbooks Wire - Status</h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                  
                  <p>
                    Magento status: Connected<br/>
					QuickBooks status: Connected
                  </p>
				  <p>
					Last synchronisation status:
					<ul>
						<li>Last sync date: Oct 20th 2015</li>
						<li>3 orders transfered from Magento to QuickBooks</li>
						<li>2 new Magento customers created into Quickbooks</li>
						<li>0 products transfered from Magento into QuickBooks</li>
						
					</ul>
				  </p>
                </div><!-- /.box-body -->
              </div>
			</div>
			
			<div class="col-md-6">
			  <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">Magento - Xero Wire - Status</h3>
                </div><!-- /.box-header -->
                <div class="box-body">
                  
                  <p>
                    Magento status: Connected<br/>
					Xero status: Connected
                  </p>
				  <p>
					Last synchronisation status:
					<ul>
						<li>Last sync date: Oct 20th 2015</li>
						<li>3 orders transfered from Magento to Xero</li>
						<li>2 new Magento customers created into Xero</li>
						<li>0 products transfered from Magento into Xero</li>
						
					</ul>
				  </p>
                </div><!-- /.box-body -->
              </div>
			</div>
			
			
		</div>
		</section>
		
