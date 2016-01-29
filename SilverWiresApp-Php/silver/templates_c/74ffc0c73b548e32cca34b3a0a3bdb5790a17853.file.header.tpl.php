<?php /* Smarty version Smarty-3.0.6, created on 2015-10-20 23:33:10
         compiled from "C:\wamp\www\silver//templates/pages/header.tpl" */ ?>
<?php /*%%SmartyHeaderCode:19685626a50605ec67-84724451%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '74ffc0c73b548e32cca34b3a0a3bdb5790a17853' => 
    array (
      0 => 'C:\\wamp\\www\\silver//templates/pages/header.tpl',
      1 => 1445373189,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '19685626a50605ec67-84724451',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>

	
<header class="main-header">
        <!-- Logo -->
        <a href="" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>A</b>LT</span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><img src="/img/logo_alb2.png" alt="logo" class="logo-default"/></span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
      <nav class="navbar navbar-static-top" role="navigation">
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img src="/adminlte/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
                  <span class="hidden-xs"><?php echo $_smarty_tpl->getVariable('user')->value->getName();?>
</span>
                </a>
                <ul class="dropdown-menu">
                  <li class="user-header">
                    <p>
                      <?php echo $_smarty_tpl->getVariable('user')->value->getName();?>

                    </p>
                  </li>
                  <li class="user-body">
                    <div class="col-xs-12 text-center">
                      <a href="/parola"><i class="icon-user"></i> Schimbare parola </a>
                    </div>
                    
                  </li>
                  <li class="user-footer">
                    <div class="pull-left">
                      <a href="/contact" class="btn btn-default btn-flat">Contact</a>
                    </div>
                    <div class="pull-right">
                      <a href="/logout" class="btn btn-default btn-flat">Sign out</a>
                    </div>
                  </li>
                </ul>
              </li>
            </ul>
          </div>
        </nav> 
      </header>	
	