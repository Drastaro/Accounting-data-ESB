<?php /* Smarty version Smarty-3.0.6, created on 2015-10-27 14:34:52
         compiled from "D:\wamp\www\silver//templates/components/index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:6338562f6f6cbcd825-53904494%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '74f04eec2e0e4ae1bbdc5ad91e4e12607e1b3904' => 
    array (
      0 => 'D:\\wamp\\www\\silver//templates/components/index.tpl',
      1 => 1445373758,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '6338562f6f6cbcd825-53904494',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_modifier_date_format')) include 'D:\wamp\www\silver\include\lib\smarty\plugins\modifier.date_format.php';
?><!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    

	<title><?php echo htmlspecialchars($_smarty_tpl->getVariable('page_meta')->value->title);?>
</title>
	<meta name="description" content="<?php echo htmlspecialchars($_smarty_tpl->getVariable('page_meta')->value->description);?>
" />
	<meta name="keywords" content="<?php echo htmlspecialchars($_smarty_tpl->getVariable('page_meta')->value->keywords);?>
" />
    
	
	<!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="/adminlte/bootstrap/css/bootstrap.min.css">
   
    <!-- Theme style -->
    <link rel="stylesheet" href="/adminlte/dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="/adminlte/dist/css/skins/_all-skins.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="/adminlte/plugins/iCheck/flat/blue.css">
    <!-- Morris chart -->
    <link rel="stylesheet" href="/adminlte/plugins/morris/morris.css">
    <!-- jvectormap -->
    <link rel="stylesheet" href="/adminlte/plugins/jvectormap/jquery-jvectormap-1.2.2.css">
    <!-- Date Picker -->
    <link rel="stylesheet" href="/adminlte/plugins/datepicker/datepicker3.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="/adminlte/plugins/daterangepicker/daterangepicker-bs3.css">
   <!-- jQuery 2.1.4 -->
    <script src="/adminlte/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]--> 
	<link rel="stylesheet" href="/css/custom.css">
	
	<link rel="shortcut icon" href="favicon.ico"/>

</head>
<body class="hold-transition skin-blue sidebar-mini <?php echo $_smarty_tpl->getVariable('pageName')->value;?>
">	
	
<?php if ($_smarty_tpl->getVariable('user')->value){?>
<div class="wrapper">
	<?php $_template = new Smarty_Internal_Template("pages/header.tpl", $_smarty_tpl->smarty, $_smarty_tpl, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null);
 echo $_template->getRenderedTemplate();?><?php $_template->updateParentVariables(0);?><?php unset($_template);?>	
	
	
	<!-- BEGIN CONTAINER -->
	
		<?php $_template = new Smarty_Internal_Template("pages/left_menu.tpl", $_smarty_tpl->smarty, $_smarty_tpl, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null);
 echo $_template->getRenderedTemplate();?><?php $_template->updateParentVariables(0);?><?php unset($_template);?>  
		
		<!-- Begin page content -->
		<div class="content-wrapper">
				
					<!-- Main content -->			   
					<?php $_template = new Smarty_Internal_Template(($_smarty_tpl->getVariable('CONTENT')->value), $_smarty_tpl->smarty, $_smarty_tpl, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null);
 echo $_template->getRenderedTemplate();?><?php $_template->updateParentVariables(0);?><?php unset($_template);?>
				
		</div>
		<!-- END CONTENT -->
	
	<!-- END CONTAINER -->
	<!-- BEGIN FOOTER -->
	<footer class="main-footer">
        <strong>Copyright &copy; <?php echo smarty_modifier_date_format(time(),"%Y");?>
 FINTECH BUSINESS SOLUTIONS</strong> All rights reserved.
     </footer>
	<!-- END FOOTER -->
	</div>
<?php }else{ ?>
	<?php $_template = new Smarty_Internal_Template(($_smarty_tpl->getVariable('CONTENT')->value), $_smarty_tpl->smarty, $_smarty_tpl, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null);
 echo $_template->getRenderedTemplate();?><?php $_template->updateParentVariables(0);?><?php unset($_template);?>
<?php }?>
	

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	  
    <!-- jQuery UI 1.11.4 -->
    <script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <script>
      $.widget.bridge('uibutton', $.ui.button);
    </script>
    <!-- Bootstrap 3.3.5 -->
    <script src="/adminlte/bootstrap/js/bootstrap.min.js"></script>
    
    <!-- Sparkline -->
    <script src="/adminlte/plugins/sparkline/jquery.sparkline.min.js"></script>
    <!-- jvectormap -->
    <script src="/adminlte/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="/adminlte/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
    <!-- jQuery Knob Chart -->
    <script src="/adminlte/plugins/knob/jquery.knob.js"></script>
    
    <!-- datepicker -->
    <script src="/adminlte/plugins/datepicker/bootstrap-datepicker.js"></script>
    <!-- Bootstrap WYSIHTML5 -->
    <script src="/adminlte/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
    <!-- Slimscroll -->
    <script src="/adminlte/plugins/slimScroll/jquery.slimscroll.min.js"></script>
    <!-- FastClick -->
    <script src="/adminlte/plugins/fastclick/fastclick.min.js"></script>
    <!-- AdminLTE App -->
    <script src="/adminlte/dist/js/app.js"></script>
    <!-- AdminLTE dashboard demo (This is only for demo purposes) 
    <script src="/adminlte/dist/js/pages/dashboard.js"></script>-->
    <!-- AdminLTE for demo purposes -->
    <script src="/adminlte/dist/js/demo.js"></script>


<!-- END PAGE LEVEL SCRIPTS -->



<!-- END JAVASCRIPTS -->
</body>
</html>