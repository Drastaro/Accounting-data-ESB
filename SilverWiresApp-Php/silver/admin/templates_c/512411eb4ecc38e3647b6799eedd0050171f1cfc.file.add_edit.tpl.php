<?php /* Smarty version Smarty-3.0.6, created on 2015-02-24 15:09:50
         compiled from "C:\wamp\www\finboard//admin/templates/administrators/add_edit.tpl" */ ?>
<?php /*%%SmartyHeaderCode:958954ec781e68cf32-98897370%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '512411eb4ecc38e3647b6799eedd0050171f1cfc' => 
    array (
      0 => 'C:\\wamp\\www\\finboard//admin/templates/administrators/add_edit.tpl',
      1 => 1415533912,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '958954ec781e68cf32-98897370',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_modifier_url')) include 'C:\wamp\www\finboard\include\lib\smarty\plugins\modifier.url.php';
?><h1><img src="<?php echo smarty_modifier_url('/');?>
admin/img/icons/administratori.png" alt=""><?php if ($_smarty_tpl->getVariable('adm')->value->id){?>Editare<?php }else{ ?>Adăugare<?php }?> administrator</h1>

<form method="post" action="">
<table class="fancytable">
	<tr>
		<th>Autentificare</th>
	</tr>
	<tr>
		<td>
			<table>
				<tr>
					<td>Nume:</td>
					<td><input type="text" value="<?php echo $_smarty_tpl->getVariable('adm')->value->name;?>
" name="name" size="50" /></td>
				</tr>
				<tr>
					<td>E-mail:</td>
					<td><input type="text" value="<?php echo $_smarty_tpl->getVariable('adm')->value->email;?>
" name="email" size="50" /></td>
				</tr>
				<tr>
					<td>Parola nouă:</td>
					<td><input type="password" value="" name="password" size="25" autocomplete="off" /></td>
				</tr>
				<tr>
					<td>Confirmare parolă:</td>
					<td><input type="password" value="" name="password2" size="25" autocomplete="off" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<th colspan="2">Access</th>
	</tr>
	<tr>
		<td colspan="2" style="line-height:25px;">
		<?php  $_smarty_tpl->tpl_vars['ad'] = new Smarty_Variable;
 $_smarty_tpl->tpl_vars['k'] = new Smarty_Variable;
 $_from = $_smarty_tpl->getVariable('accessData')->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
if ($_smarty_tpl->_count($_from) > 0){
    foreach ($_from as $_smarty_tpl->tpl_vars['ad']->key => $_smarty_tpl->tpl_vars['ad']->value){
 $_smarty_tpl->tpl_vars['k']->value = $_smarty_tpl->tpl_vars['ad']->key;
?>
			<input type="checkbox" name="access[]" value="<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
" id="acc<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
" <?php if (($_smarty_tpl->getVariable('adm')->value->hasAccess($_smarty_tpl->tpl_vars['k']->value))){?> checked="checked" <?php }?>>
			<label for="acc<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
"><?php echo $_smarty_tpl->tpl_vars['ad']->value;?>
</label>
			<br>
		<?php }} ?>
		</td>
	</tr>
</table>
<p align="center">
	<input type="submit" value=" Save " class="button" />
	<a href="?page=administrators&amp;action=list" class="button">Cancel</a>
</p>
</form>