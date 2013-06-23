<?php /* Smarty version Smarty-3.1.13, created on 2013-05-25 10:07:22
         compiled from "/Users/andreylukin/PhpStorm/mipt/protected/views/layouts/main.tpl" */ ?>
<?php /*%%SmartyHeaderCode:213682548651a052dfa5d343-28078345%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'dee99a66f7a3633c61eee7a1e9feee558fc2bd94' => 
    array (
      0 => '/Users/andreylukin/PhpStorm/mipt/protected/views/layouts/main.tpl',
      1 => 1369462035,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '213682548651a052dfa5d343-28078345',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_51a052dface8f4_16467031',
  'variables' => 
  array (
    'this' => 0,
    'content' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_51a052dface8f4_16467031')) {function content_51a052dface8f4_16467031($_smarty_tpl) {?><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title><?php echo $_smarty_tpl->tpl_vars['this']->value->pageTitle;?>
</title>
</head>

<body>

<div class="header">
	<div class="navbar navbar-inverse navbar-static-top">
		<div class="navbar-inner">
			<div class="container">
				<a class="brand" href="">MIPT SQL Benchmark</a>
				<div class="pull-right">
					
					
					
				</div>
			</div>
		</div>
	</div>
</div>


<div class="content">

</div>
<?php echo $_smarty_tpl->tpl_vars['content']->value;?>




</body>
</html><?php }} ?>