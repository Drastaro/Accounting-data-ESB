<?php /* Smarty version Smarty-3.0.6, created on 2014-11-09 20:00:46
         compiled from "C:\wamp\www\finboard//admin/templates/components/index.tpl" */ ?>
<?php /*%%SmartyHeaderCode:309545fabce0a08d9-36740598%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '3bd65a4f23dde2ebff4d1c3675074b4f08f504b6' => 
    array (
      0 => 'C:\\wamp\\www\\finboard//admin/templates/components/index.tpl',
      1 => 1415533912,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '309545fabce0a08d9-36740598',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_modifier_url')) include 'C:\wamp\www\finboard\include\lib\smarty\plugins\modifier.url.php';
?><!doctype html>
<html>
<head>
	<meta charset="UTF-8">

	<title><?php echo $_smarty_tpl->getVariable('config')->value->page_meta->title;?>
</title>
	<link rel="icon" type="image/png" href="<?php echo smarty_modifier_url('/');?>
admin/img/favicon.png" />

	<link href="<?php echo smarty_modifier_url('/');?>
admin/css/jquery-ui-1.10.0.custom.css" type="text/css" rel="stylesheet" />
	<link href="<?php echo smarty_modifier_url('/');?>
admin/css/index.css" type="text/css" rel="stylesheet" />
	
	<script type="text/javascript" src="<?php echo smarty_modifier_url('/');?>
admin/js/jquery-1.9.0.js"></script>
	<script type="text/javascript" src="<?php echo smarty_modifier_url('/');?>
admin/js/jquery-ui-1.10.0.custom.js"></script>
	<script type="text/javascript" src="<?php echo smarty_modifier_url('/');?>
admin/js/generic.js"></script>
</head>
<body>
	<div id="topBar">
		<div class="topBreadcrumb">
            <a href="<?php echo smarty_modifier_url('/');?>
admin/" class="topBreadcrumbLogo"><?php echo $_smarty_tpl->getVariable('config')->value->project_name;?>
</a> :: <?php echo $_smarty_tpl->getVariable('breadCrumbHtml')->value;?>

		</div>
		<div class="topMenu">
			<?php if ($_smarty_tpl->getVariable('ADMIN')->value){?>
				<a href='?page=logout'>Logout</a> [<?php echo $_smarty_tpl->getVariable('ADMIN')->value->name;?>
]
			<?php }?>
		</div>
	</div>
	<div id="noticeBox" class="<?php echo $_smarty_tpl->getVariable('noticeBoxColor')->value;?>
">
		<a id="noticeBoxClose" href="#">x</a>
		<div id="noticeBoxText"><?php echo $_smarty_tpl->getVariable('noticeBoxMessages')->value;?>
</div>
	</div>
	<?php $_template = new Smarty_Internal_Template($_smarty_tpl->getVariable('CONTENT')->value, $_smarty_tpl->smarty, $_smarty_tpl, $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, null, null);
 echo $_template->getRenderedTemplate();?><?php $_template->updateParentVariables(0);?><?php unset($_template);?>
</body>
</html>