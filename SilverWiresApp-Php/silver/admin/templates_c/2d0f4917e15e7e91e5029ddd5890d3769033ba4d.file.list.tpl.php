<?php /* Smarty version Smarty-3.0.6, created on 2015-02-24 15:08:42
         compiled from "C:\wamp\www\finboard//admin/templates/companies/list.tpl" */ ?>
<?php /*%%SmartyHeaderCode:1174454ec77da4d61e1-96324223%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '2d0f4917e15e7e91e5029ddd5890d3769033ba4d' => 
    array (
      0 => 'C:\\wamp\\www\\finboard//admin/templates/companies/list.tpl',
      1 => 1415533912,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '1174454ec77da4d61e1-96324223',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_modifier_url')) include 'C:\wamp\www\finboard\include\lib\smarty\plugins\modifier.url.php';
?><div class="leftCPbox">
	<form action="" method="get">
	<input type="hidden" name="page" value="companies">
	<input type="hidden" name="action" value="list">
	
	<h1><img src="<?php echo smarty_modifier_url('/');?>
admin/img/icons/companies.png" alt="">Companies</h1>
	<div align="center">[<a href="?page=companies&amp;action=add_edit">adăugare</a>]</div>
	<br />
	
	<label>ID:</label> <input type="text" name="id" value="<?php echo $_smarty_tpl->getVariable('id')->value;?>
">

    <label>User ID:</label> <input type="text" name="user_id" value="<?php echo $_smarty_tpl->getVariable('user_id')->value;?>
">
	
	<label>Nume:</label> <input type="text" name="name" value="<?php echo $_smarty_tpl->getVariable('name')->value;?>
">
	
	<label>Ordonare:</label>
	<select name="orderby_what" size="1" style="width:70px;">
		<option value="id">ID</option>
		<option value="name"<?php if ($_smarty_tpl->getVariable('orderby_what')->value=='name'){?> selected<?php }?>>Nume</option>
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
		[<a href="?page=companies&amp;action=list">resetare formular</a>]
	</p>
	</form>
</div>

<div style="margin-left:151px;">

	<table class="fancytable actiontable" style="width:100%">
		<tr>
			<th width="10">ID</th>
			<th>Nume</th>
            <th>User</th>
			<th width="70">Opțiuni</th>
		</tr>
		<?php  $_smarty_tpl->tpl_vars['r'] = new Smarty_Variable;
 $_from = $_smarty_tpl->getVariable('res')->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
if ($_smarty_tpl->_count($_from) > 0){
    foreach ($_from as $_smarty_tpl->tpl_vars['r']->key => $_smarty_tpl->tpl_vars['r']->value){
?>
		<tr>
			<td align="right"><?php echo $_smarty_tpl->getVariable('r')->value->id;?>
</td>
			<td><strong><a href="?page=companies&amp;action=add_edit&amp;id=<?php echo $_smarty_tpl->getVariable('r')->value->id;?>
"><?php echo $_smarty_tpl->getVariable('r')->value->name;?>
</a></strong></td>
            <td><strong><a href="?page=users&amp;action=add_edit&amp;id=<?php echo $_smarty_tpl->getVariable('r')->value->user_id;?>
"><?php echo $_smarty_tpl->getVariable('r')->value->user_name;?>
</a></strong></td>
			<td>
				<div class="simple-combo">
					<a class="ctrl" href="#">&or;</a>
					<div>
						<a href="?page=companies&amp;action=add_edit&amp;id=<?php echo $_smarty_tpl->getVariable('r')->value->id;?>
">Editare</a>
							
                        <a href="?page=companies&amp;action=delete&amp;id=<?php echo $_smarty_tpl->getVariable('r')->value->id;?>
"
                           onclick="return confirm('Doriți să ștergeți definitiv compania <?php echo $_smarty_tpl->getVariable('r')->value->name;?>
?')"
                            >Ștergere</a>
					</div>
				</div>
			</td>
		</tr>
		<?php }} else { ?>
		<tr>
			<td colspan="16" align="center">- nu a fost găsit nici o companie -</td>
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

