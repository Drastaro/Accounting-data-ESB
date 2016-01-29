<?php /* Smarty version Smarty-3.0.6, created on 2014-11-09 20:00:54
         compiled from "C:\wamp\www\finboard//admin/templates/home.tpl" */ ?>
<?php /*%%SmartyHeaderCode:19070545fabd6d59058-99635997%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '3f5064f0b89e9f84229f0960f2ed4fe45125dca9' => 
    array (
      0 => 'C:\\wamp\\www\\finboard//admin/templates/home.tpl',
      1 => 1415533912,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '19070545fabd6d59058-99635997',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_modifier_url')) include 'C:\wamp\www\finboard\include\lib\smarty\plugins\modifier.url.php';
?><?php if ($_smarty_tpl->getVariable('ADMIN')->value->hasAccessToPage('companies')||$_smarty_tpl->getVariable('ADMIN')->value->hasAccessToPage('users')||$_smarty_tpl->getVariable('ADMIN')->value->hasAccessToPage('administrators')){?>
<table align="center" cellspacing="1" cellpadding="3" width="600" class="fancytable dashboard">
  <tr>
    <th>Secțiuni</th>
  </tr>
  <tr>
    <td><table cellspacing="5" width="100%" align="left">
        <tr>
        <?php if ($_smarty_tpl->getVariable('ADMIN')->value->hasAccessToPage('companies')){?>
          <td valign="top" width="17%"><div align="center"><a href="?page=companies&amp;action=list"><img src="<?php echo smarty_modifier_url('/');?>
admin/img/icons/companies.png" border="0" alt=""><br>
              Companii
          </a></div></td>
        <?php }?>
        <?php if ($_smarty_tpl->getVariable('ADMIN')->value->hasAccessToPage('users')){?>
          <td valign="top" width="17%"><div align="center"><a href="?page=users&amp;action=list"><img src="<?php echo smarty_modifier_url('/');?>
admin/img/icons/users.png" border="0" alt=""><br>
              Clienți
          </a></div></td>
        <?php }?>
        <?php if ($_smarty_tpl->getVariable('ADMIN')->value->hasAccessToPage('administrators')){?>
          <td valign="top" width="17%"><div align="center"><a href="?page=administrators&amp;action=list"><img src="<?php echo smarty_modifier_url('/');?>
admin/img/icons/administratori.png" border="0" alt=""><br>
              Administratori
          </a></div></td>
        <?php }?>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
<br>
<?php }?>
