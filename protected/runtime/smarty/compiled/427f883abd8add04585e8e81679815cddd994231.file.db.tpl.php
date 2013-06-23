<?php /* Smarty version Smarty-3.1.13, created on 2013-05-26 13:14:37
         compiled from "/Users/andreylukin/PhpStorm/mipt/protected/modules/admin/views/edit/db/db.tpl" */ ?>
<?php /*%%SmartyHeaderCode:9102808551a09b678b8a38-59588180%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '427f883abd8add04585e8e81679815cddd994231' => 
    array (
      0 => '/Users/andreylukin/PhpStorm/mipt/protected/modules/admin/views/edit/db/db.tpl',
      1 => 1369559670,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '9102808551a09b678b8a38-59588180',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.13',
  'unifunc' => 'content_51a09b678b93a1_70732978',
  'variables' => 
  array (
    'tables' => 0,
    'table' => 0,
    'table_name' => 0,
    'Yii' => 0,
    'this' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_51a09b678b93a1_70732978')) {function content_51a09b678b93a1_70732978($_smarty_tpl) {?><div class="row-fluid">
	<div class="span3 tables">
		<h4>Доступные таблицы</h4>

		<?php  $_smarty_tpl->tpl_vars['table'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['table']->_loop = false;
 $_smarty_tpl->tpl_vars['table_name'] = new Smarty_Variable;
 $_from = $_smarty_tpl->tpl_vars['tables']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['table']->key => $_smarty_tpl->tpl_vars['table']->value){
$_smarty_tpl->tpl_vars['table']->_loop = true;
 $_smarty_tpl->tpl_vars['table_name']->value = $_smarty_tpl->tpl_vars['table']->key;
?>
			<p id="table-name-<?php echo $_smarty_tpl->tpl_vars['table']->value['id'];?>
">
				<a  href="#" onclick="return showTableDescription('<?php echo $_smarty_tpl->tpl_vars['table']->value['id'];?>
');">
					<?php echo $_smarty_tpl->tpl_vars['table_name']->value;?>

				</a>
			</p>
			
				
					
						
						
					
					
						
							
							
						
					
				
			
		<?php } ?>
	</div>
	<div class="span9">
		<div class="page-header">
			<h1>База Данных</h1>
		</div>

		<div class="upload-tables">
			<div class="row">
				<div class="span12">
					<blockquote>
						<p>
							Загрузить *.sql скрипт.<br/>
							Вы можете указать префикс таблиц, если такой существует <br/>
						</p>
					</blockquote>
				</div>
			</div>
			<div class="row">
				<div class="span3">
					<button class="btn btn-info btn-large"  id='fileupload-button'>
						<span> Загрузить SQL скрипт </span>
					</button>
					<input id='fileupload' type="file" name="files[]" data-url='' >
				</div>
				<div class="span5 hidden" id='execute-block'>
					<div class="row-fluid">
						<div class="span4">
							<button class="btn" id="execute">Выполнить</button>
						</div>
						<div class="span8">
							<label>
								<span> Префикс таблиц &nbsp; </span>
								<input id='table_prefix' type="text" class="input-mini">
							</label>
						</div>

					</div>
				</div>
				<div class="span4">
					<div id="filename"></div>
				</div>



				<?php echo $_smarty_tpl->tpl_vars['this']->value->widget('admin.extensions.EFineUploader.EFineUploader',array('id'=>'execute','config'=>array('autoUpload'=>true,'request'=>array('endpoint'=>array('admin/edit/db','action'=>'upload'),'params'=>array('YII_CSRF_TOKEN'=>$_smarty_tpl->tpl_vars['Yii']->value->request->csrfToken)),'validation'=>array('allowedExtensions'=>array('sql'),'sizeLimit'=>100*1024),'chunking'=>array('enable'=>true,'partSize'=>100),'callbacks'=>array('onComplete'=>"js:Admin.uploadComplete"))));?>

			</div>
		</div>
	</div>
</div><?php }} ?>