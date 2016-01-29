<?php /* Smarty version Smarty-3.0.6, created on 2014-11-09 20:00:46
         compiled from "C:\wamp\www\finboard//admin/templates/components/login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:22986545fabce5224d7-53610998%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '92df0f3a7edf971bf24fa4680fc99d63792639ea' => 
    array (
      0 => 'C:\\wamp\\www\\finboard//admin/templates/components/login.tpl',
      1 => 1415533912,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '22986545fabce5224d7-53610998',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<br><br>
<br><br>

<form method="post" action="?page=login" >
<table class="fancytable">
<tr>
	<th>Autentificare</th>
</tr>
<tr>
	<td>
		
		<table>
			<tr>
				<td align="right">Administrator:</td>
				<td><input type="text" name="email" size="25" id="email"></td>
			</tr>
			<tr>
				<td align="right">Parolă:</td>
				<td><input type="password" name="password" size="25"></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="submit" name="login" value="Login" class="button">
				</td>
			</tr>
		</table>
	</td>
</tr>
</table><br><br><br>
</form>

<script type="text/javascript">
	document.getElementById('email').focus();
</script>
