<?php /* Smarty version Smarty-3.1.13, created on 2013-05-25 16:23:30
         compiled from "/Users/andreylukin/PhpStorm/mipt/protected/modules/admin/views/layouts/main.tpl" */ ?>
<?php /*%%SmartyHeaderCode:198149565851a052df6f60c5-20527462%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '9d85ba48ff7c4a9f32c0589665fe53aae5400b1c' => 
    array (
      0 => '/Users/andreylukin/PhpStorm/mipt/protected/modules/admin/views/layouts/main.tpl',
      1 => 1369484274,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '198149565851a052df6f60c5-20527462',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_51a052df757c86_60097394',
  'variables' => 
  array (
    'this' => 0,
    'Yii' => 0,
    'content' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_51a052df757c86_60097394')) {function content_51a052df757c86_60097394($_smarty_tpl) {?><?php if (!is_callable('smarty_function_link')) include '/Users/andreylukin/PhpStorm/mipt/protected/extensions/Smarty/plugins/function.link.php';
?><!DOCTYPE html>
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

				<?php echo smarty_function_link(array('text'=>'MIPT SQL Benchmark','url'=>'/admin','class'=>'brand'),$_smarty_tpl);?>


				<?php if (!$_smarty_tpl->tpl_vars['Yii']->value->user->isGuest){?>
					<?php echo $_smarty_tpl->tpl_vars['this']->value->widget('bootstrap.widgets.TbMenu',array('type'=>'','items'=>array(array('label'=>'База Данных','icon'=>'upload','url'=>array('/admin/edit/db')),array('label'=>'Тесты','icon'=>'pencil','url'=>array('/admin/edit/test')),array('label'=>'Вопросы','icon'=>'edit','url'=>array('/admin/edit/question')))),true);?>

				<?php }?>

				<div class="pull-right">
					<?php if (!$_smarty_tpl->tpl_vars['Yii']->value->user->isGuest){?>
						<?php echo smarty_function_link(array('text'=>'Выйти','url'=>'admin/logout','class'=>'brand'),$_smarty_tpl);?>

					<?php }?>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="content">
	<div class="container-fluid">

		<div class="row-fluid">


			<div class="span10">
				<?php echo $_smarty_tpl->tpl_vars['content']->value;?>

			</div>
			<?php if (!$_smarty_tpl->tpl_vars['Yii']->value->user->isGuest){?>
				<div class="span2">

				</div>
			<?php }?>

		</div>

	</div>
</div>




</body>
</html><?php }} ?>