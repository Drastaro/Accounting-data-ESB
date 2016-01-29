<?php /* Smarty version Smarty-3.0.6, created on 2014-11-09 20:02:01
         compiled from "C:\wamp\www\finboard//admin/templates/users/add_edit.tpl" */ ?>
<?php /*%%SmartyHeaderCode:11596545fac197dd122-89583725%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'a77d83c5648ba0bd9b52c7a5073dca92bdebe227' => 
    array (
      0 => 'C:\\wamp\\www\\finboard//admin/templates/users/add_edit.tpl',
      1 => 1415533912,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '11596545fac197dd122-89583725',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_modifier_url')) include 'C:\wamp\www\finboard\include\lib\smarty\plugins\modifier.url.php';
if (!is_callable('smarty_modifier_escape')) include 'C:\wamp\www\finboard\include\lib\smarty\plugins\modifier.escape.php';
?><h1><img src="<?php echo smarty_modifier_url('/');?>
admin/img/icons/users.png" alt=""><?php if (!$_smarty_tpl->getVariable('res')->value->id){?>Adăugare user<?php }else{ ?>Editare: <?php echo $_smarty_tpl->getVariable('res')->value->getName();?>
<?php }?></h1>

<form action="" method="post">
<?php if ($_smarty_tpl->getVariable('res')->value->id){?><input type="hidden" name="id" value="<?php echo $_smarty_tpl->getVariable('res')->value->id;?>
"><?php }?>
<table class="fancytable">
	<tr>
		<th colspan="2">Detalii</th>
	</tr>
	<tr>
		<td>
			<table>
				<tr>
					<td>Nume:</td>
					<td><input type="text" value="<?php echo smarty_modifier_escape($_smarty_tpl->getVariable('res')->value->last_name);?>
" name="last_name" size="50" /></td>
				</tr>
				<tr>
					<td>Prenume:</td>
					<td><input type="text" value="<?php echo smarty_modifier_escape($_smarty_tpl->getVariable('res')->value->first_name);?>
" name="first_name" size="50" /></td>
				</tr>
				<tr>
					<td>E-mail:</td>
					<td><input type="text" value="<?php echo smarty_modifier_escape($_smarty_tpl->getVariable('res')->value->email);?>
" name="email" size="50" /></td>
				</tr>
				<tr>
					<td>Telefon:</td>
					<td><input type="text" value="<?php echo smarty_modifier_escape($_smarty_tpl->getVariable('res')->value->telephone);?>
" name="telephone" size="50" /></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<p align="center">
	<input type="submit" value="Salvează" class="button">
	<a class="button" href="?page=users&amp;action=list">Renunță</a>
</p>
</form>
