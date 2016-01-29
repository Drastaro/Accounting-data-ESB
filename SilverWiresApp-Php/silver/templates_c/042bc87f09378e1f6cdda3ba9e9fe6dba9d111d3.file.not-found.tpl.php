<?php /* Smarty version Smarty-3.0.6, created on 2015-09-04 14:04:14
         compiled from "C:\wamp\www\silver//templates/components/not-found.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2870555e97aaec821a5-86402740%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '042bc87f09378e1f6cdda3ba9e9fe6dba9d111d3' => 
    array (
      0 => 'C:\\wamp\\www\\silver//templates/components/not-found.tpl',
      1 => 1415533916,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2870555e97aaec821a5-86402740',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_modifier_url')) include 'C:\wamp\www\silver\include\lib\smarty\plugins\modifier.url.php';
?><div class="section-header">
    <div class="container">
        <h1 class="page-header">Pagină inexistentă</h1>
    </div>
</div>

<div id="content" class="container">
    <br>
    <h4>Pagina pe care ați încercat să o accesați nu există pe acest website.</h4>

    <p class="box">
        În scurt timp veți fi redirectionați către <a href="<?php echo smarty_modifier_url('/');?>
">prima pagină</a>.
        Dacă nu doriți să așteptați, <a href="<?php echo smarty_modifier_url('/');?>
">apăsați aici</a>!
    </p>
</div>

<script type="text/javascript">
<!--
	setTimeout(function() {
		  window.location.replace('<?php echo smarty_modifier_url('/');?>
');
	}, 10000);
//-->
</script>