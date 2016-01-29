<?php /* Smarty version Smarty-3.0.6, created on 2015-02-24 15:09:49
         compiled from "C:\wamp\www\finboard//admin/templates/administrators/list.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2167654ec781d210c73-43195037%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'd274ee675a8b8191e4e8049401cd65a3d0df5dec' => 
    array (
      0 => 'C:\\wamp\\www\\finboard//admin/templates/administrators/list.tpl',
      1 => 1415533912,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2167654ec781d210c73-43195037',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_modifier_url')) include 'C:\wamp\www\finboard\include\lib\smarty\plugins\modifier.url.php';
?><h1><img src="<?php echo smarty_modifier_url('/');?>
admin/img/icons/administratori.png" alt="">Administratori</h1>

<table class="fancytable actiontable">
	<tr>
		<th>Nume</th>
		<th>E-mail</th>
		<th>Opțiuni</th>
	</tr>
	
	<?php  $_smarty_tpl->tpl_vars['adm'] = new Smarty_Variable;
 $_from = $_smarty_tpl->getVariable('administrators')->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
if ($_smarty_tpl->_count($_from) > 0){
    foreach ($_from as $_smarty_tpl->tpl_vars['adm']->key => $_smarty_tpl->tpl_vars['adm']->value){
?>
	<tr>
		<td><?php echo $_smarty_tpl->getVariable('adm')->value->name;?>
</td>
		<td><?php echo $_smarty_tpl->getVariable('adm')->value->email;?>
</td>
		<td>
			<a href="?page=administrators&amp;action=add_edit&amp;id=<?php echo $_smarty_tpl->getVariable('adm')->value->id;?>
">Editare</a>
			 - 
			<a href="?page=administrators&amp;action=remove&amp;id=<?php echo $_smarty_tpl->getVariable('adm')->value->id;?>
" 
				onclick="return confirm('Confirm ștergerea administratorului!');">Ștergere</a>
		</td>
	</tr>
	<?php }} ?>
</table>

<p align="center"><a class="button" href="?page=administrators&amp;action=add_edit">Adaugă</a></p>