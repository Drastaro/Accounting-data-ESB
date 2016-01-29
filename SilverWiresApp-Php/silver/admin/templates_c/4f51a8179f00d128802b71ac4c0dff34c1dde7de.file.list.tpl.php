<?php /* Smarty version Smarty-3.0.6, created on 2014-11-09 20:01:03
         compiled from "C:\wamp\www\finboard//admin/templates/users/list.tpl" */ ?>
<?php /*%%SmartyHeaderCode:18815545fabdf735ec4-97625411%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4f51a8179f00d128802b71ac4c0dff34c1dde7de' => 
    array (
      0 => 'C:\\wamp\\www\\finboard//admin/templates/users/list.tpl',
      1 => 1415533912,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '18815545fabdf735ec4-97625411',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_modifier_url')) include 'C:\wamp\www\finboard\include\lib\smarty\plugins\modifier.url.php';
?><div class="leftCPbox">
	<form action="" method="get">
	<input type="hidden" name="page" value="users">
	<input type="hidden" name="action" value="list">
	
	<h1><img src="<?php echo smarty_modifier_url('/');?>
admin/img/icons/users.png" alt="">Users</h1>
	<div align="center">[<a href="?page=users&amp;action=add_edit">adăugare</a>]</div>
	<br />
	
	<label>ID:</label> <input type="text" name="id" value="<?php echo $_smarty_tpl->getVariable('id')->value;?>
">
	
	<label>Nume:</label> <input type="text" name="name" value="<?php echo $_smarty_tpl->getVariable('name')->value;?>
">
	
	<label>E-mail:</label> <input type="text" name="email" value="<?php echo $_smarty_tpl->getVariable('email')->value;?>
">
	
	<label>Phone:</label> <input type="text" name="phone" value="<?php echo $_smarty_tpl->getVariable('phone')->value;?>
">
	
	<label>Activ:&nbsp;&nbsp;
	<select name="active" size="1">
        <option value="">Toti</option>
		<option value="1"<?php if ($_smarty_tpl->getVariable('active')->value=='1'){?> selected<?php }?>>Da</option>
		<option value="0"<?php if ($_smarty_tpl->getVariable('active')->value=='0'){?> selected<?php }?>>Nu</option>
	</select>
	</label>
	
	<label>Ordonare:</label>
	<select name="orderby_what" size="1" style="width:70px;">
		<option value="id">ID</option>
		<option value="name"<?php if ($_smarty_tpl->getVariable('orderby_what')->value=='name'){?> selected<?php }?>>Nume</option>
		<option value="email"<?php if ($_smarty_tpl->getVariable('orderby_what')->value=='email'){?> selected<?php }?>>E-mail</option>
	</select>
	<select name="orderby_how" size="1" style="width:53px;">
		<option value="ASC">ASC</option>
		<option value="DESC"<?php if ($_smarty_tpl->getVariable('orderby_how')->value=='DESC'){?> selected<?php }?>>DES</option>
	</select>
	
	<label>Rezultate/pag: <input type="text" name="rezultate" value="<?php echo $_smarty_tpl->getVariable('rezultate')->value;?>
" style="width:30px;"></label>
	
	<p align="center"><input type="submit" value="Caută" class="button"></p>
	
	<p align="center">
		<strong>Nr. rezultate: <?php echo $_smarty_tpl->getVariable('total')->value;?>
</strong>
		<br />
		[<a href="?page=users&amp;action=list">resetare formular</a>]
	</p>
	</form>
</div>

<div style="margin-left:151px;">

	<table class="fancytable actiontable" style="width:100%">
		<tr>
			<th width="10">ID</th>
			<th>Nume</th>
			<th>E-mail</th>
			<th>Telefon</th>
            <th>Status</th>
			<th width="70">Opțiuni</th>
		</tr>
		<?php  $_smarty_tpl->tpl_vars['r'] = new Smarty_Variable;
 $_from = $_smarty_tpl->getVariable('res')->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
if ($_smarty_tpl->_count($_from) > 0){
    foreach ($_from as $_smarty_tpl->tpl_vars['r']->key => $_smarty_tpl->tpl_vars['r']->value){
?>
		<tr <?php if ($_smarty_tpl->getVariable('r')->value->isActive==0){?>class="text-inactive"<?php }?>>
			<td align="right"><?php echo $_smarty_tpl->getVariable('r')->value->id;?>
</td>
			<td><strong><a href="?page=users&amp;action=add_edit&amp;id=<?php echo $_smarty_tpl->getVariable('r')->value->id;?>
"><?php echo $_smarty_tpl->getVariable('r')->value->getName();?>
</a></strong></td>
			<td><?php if ($_smarty_tpl->getVariable('r')->value->isConfirmed){?><a href="mailto:<?php echo $_smarty_tpl->getVariable('r')->value->email;?>
"><?php echo $_smarty_tpl->getVariable('r')->value->email;?>
</a><?php }else{ ?><?php echo $_smarty_tpl->getVariable('r')->value->email;?>
 <b class="hl2">- NECONFIRMAT</b><?php }?></td>
			<td><?php echo $_smarty_tpl->getVariable('r')->value->telephone;?>
</td>
            <td><?php if ($_smarty_tpl->getVariable('r')->value->isActive){?>Activ<?php }else{ ?>Inactiv<?php }?></td>
			<td>
				<div class="simple-combo">
					<a class="ctrl" href="#">&or;</a>
					<div>
						<a href="?page=users&amp;action=add_edit&amp;id=<?php echo $_smarty_tpl->getVariable('r')->value->id;?>
">Editare</a>
							
						<a href="?page=users&amp;action=toggle&amp;id=<?php echo $_smarty_tpl->getVariable('r')->value->id;?>
"
							onclick="return confirm('Doriți să <?php if ($_smarty_tpl->getVariable('r')->value->isActive){?>dezactivați<?php }else{ ?>activați<?php }?> userul <?php echo $_smarty_tpl->getVariable('r')->value->getName();?>
?')"
							><?php if ($_smarty_tpl->getVariable('r')->value->isActive){?>Dezactivare<?php }else{ ?>Activare<?php }?></a>

                        <a href="?page=users&amp;action=delete&amp;id=<?php echo $_smarty_tpl->getVariable('r')->value->id;?>
"
                           onclick="return confirm('Doriți să ștergeți definitiv userul <?php echo $_smarty_tpl->getVariable('r')->value->getName();?>
?')"
                            >Ștergere</a>
					</div>
				</div>
			</td>
		</tr>
		<?php }} else { ?>
		<tr>
			<td colspan="16" align="center">- nu a fost găsit nici un user -</td>
		</tr>
		<?php } ?>
	</table>
	<div class="pageslinks" align="center">
		<?php echo $_smarty_tpl->getVariable('paginator')->value;?>

	</div>
	
</div>


<script type="text/javascript">
<!--
	$('.simple-combo .ctrl').click(function(){
		if ($(this).parent().find('div').css('position') == 'static') {
			$('.simple-combo div').css({position:'static'});
			$(this).parent().find('div').css({position:'absolute'});
		} else {
			$('.simple-combo div').css({position:'static'});
		}
		return false;
	});

	$('.combobox').combobox();
//-->
</script>

