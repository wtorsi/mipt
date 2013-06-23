<?php /* Smarty version Smarty-3.1.13, created on 2013-05-25 11:11:23
         compiled from "/Users/andreylukin/PhpStorm/mipt/protected/modules/admin/views/default/login/login.tpl" */ ?>
<?php /*%%SmartyHeaderCode:111810072251a052df68cc94-02940643%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '0f95a99fe087b1116514ec29b68d21627e9b1e61' => 
    array (
      0 => '/Users/andreylukin/PhpStorm/mipt/protected/modules/admin/views/default/login/login.tpl',
      1 => 1369465757,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '111810072251a052df68cc94-02940643',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_51a052df6f1315_80168104',
  'variables' => 
  array (
    'model' => 0,
    'login_form' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_51a052df6f1315_80168104')) {function content_51a052df6f1315_80168104($_smarty_tpl) {?><?php if (!is_callable('smarty_block_form')) include '/Users/andreylukin/PhpStorm/mipt/protected/extensions/Smarty/plugins/block.form.php';
if (!is_callable('smarty_function_widget')) include '/Users/andreylukin/PhpStorm/mipt/protected/extensions/Smarty/plugins/function.widget.php';
?><div class="row">
	<div class="login-form">

		<?php $_smarty_tpl->smarty->_tag_stack[] = array('form', array('name'=>"login_form",'id'=>'form','class'=>'well')); $_block_repeat=true; echo smarty_block_form(array('name'=>"login_form",'id'=>'form','class'=>'well'), null, $_smarty_tpl, $_block_repeat);while ($_block_repeat) { ob_start();?>

			<?php echo $_smarty_tpl->tpl_vars['login_form']->value->textFieldRow($_smarty_tpl->tpl_vars['model']->value,'username',array('class'=>'span3','maxlength'=>255));?>

			<?php echo $_smarty_tpl->tpl_vars['login_form']->value->passwordFieldRow($_smarty_tpl->tpl_vars['model']->value,'password',array('class'=>'span3','maxlength'=>255));?>



			<?php echo smarty_function_widget(array('name'=>'bootstrap.widgets.TbButton','buttonType'=>'submit','label'=>'Войти'),$_smarty_tpl);?>


		<?php $_block_content = ob_get_clean(); $_block_repeat=false; echo smarty_block_form(array('name'=>"login_form",'id'=>'form','class'=>'well'), $_block_content, $_smarty_tpl, $_block_repeat);  } array_pop($_smarty_tpl->smarty->_tag_stack);?>

		


			
			
			
				
				
					
					
				

			
			
				
				
					
					
				


			
			
				
					
				

			
		
	</div>
</div>

<?php }} ?>