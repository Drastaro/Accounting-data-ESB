<?php /* Smarty version Smarty-3.0.6, created on 2015-10-27 14:36:36
         compiled from "D:\wamp\www\silver//templates/components/not-found.tpl" */ ?>
<?php /*%%SmartyHeaderCode:9368562f6fd4372798-10410917%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '715c883aaa47192ebdeb5b61a8ccb6d83668c5dc' => 
    array (
      0 => 'D:\\wamp\\www\\silver//templates/components/not-found.tpl',
      1 => 1415533916,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '9368562f6fd4372798-10410917',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
)); /*/%%SmartyHeaderCode%%*/?>
<?php if (!is_callable('smarty_modifier_url')) include 'D:\wamp\www\silver\include\lib\smarty\plugins\modifier.url.php';
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