<?php /* Smarty version Smarty-3.0.6, created on 2015-10-27 14:36:35
         compiled from "D:\wamp\www\silver//templates/pages/left_menu.tpl" */ ?>
<?php /*%%SmartyHeaderCode:21091562f6fd3cd7981-28646934%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '801a2fe641047a60c86118e42f52004677ec7f7d' => 
    array (
      0 => 'D:\\wamp\\www\\silver//templates/pages/left_menu.tpl',
      1 => 1445374210,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '21091562f6fd3cd7981-28646934',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
          <!-- Sidebar user panel -->
          
          <br/>
          <!-- sidebar menu: : style can be found in sidebar.less -->
          <ul class="sidebar-menu">
           <li class="treeview active">
              <a href="/">
                <span>Dashboard</span>
              </a>
            </li>
            <li class="treeview active">
              <a href="#">
                <i class="fa fa-files-o"></i>
                <span>Magento - Quickbooks Wire</span>
                <span class="label label-primary pull-right">1</span>
              </a>
              <ul class="treeview-menu menu-open" style="display:block">
				<li><a href="/magento_settings"><i class="fa fa-circle-o"></i> Magento settings</a></li>
				<li><a href="/quickbooks_settings"><i class="fa fa-circle-o"></i> Quickbooks settings</a></li>
				<li><a href="/magento_quickbooks_mapping"><i class="fa fa-circle-o"></i> Data mapping</a></li>
				<li><a href="/magento_quickbooks_log"><i class="fa fa-circle-o"></i> Sync log</a></li>
              </ul>
			 </li>
			  <li class="treeview active">
			  <a href="#">
                <i class="fa fa-files-o"></i>
                <span>Magento - Xero Wire</span>
                <span class="label label-primary pull-right">1</span>
              </a>
              <ul class="treeview-menu menu-open" style="display:block">
				<li><a href="/magento_settings"><i class="fa fa-circle-o"></i> Magento settings</a></li>
				<li><a href="/xero_settings"><i class="fa fa-circle-o"></i> Xero settings</a></li>
				<li><a href="/magento_xero_mapping"><i class="fa fa-circle-o"></i> Data mapping</a></li>
				<li><a href="/magento_xero_log"><i class="fa fa-circle-o"></i> Sync log</a></li>
              </ul>
            </li>
           
            
          </ul>
		  
        </section>
        <!-- /.sidebar -->
      </aside>

