<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 18:41
 * To change this template use File | Settings | File Templates.
 */
/**
 * @var $this  UserController
 * @var $form  TbActiveForm
 * @var $model RegisterForm
 */
?>

<div class="container" style="margin-top: 100px">

	<? $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
		'id'                     => "register-form",
		'type'                   => 'horizontal',
		'enableClientValidation' => false,
		'enableAjaxValidation'  => false,
		'clientOptions'=>array(

			'validateOnSubmit'=>true,
			'validateOnChange'=>false,
			'validateOnType'=>false
		),
	))
	?>
	<fieldset>
		<div class="row-fluid">
			<div class="span6 offset3">
				<legend>Регистрация</legend>
			</div>
		</div>
		<div class="row-fluid">
			<div class="span6 offset3">



				<?=$form->textFieldRow($model, 'name')?>
				<?=$form->textFieldRow($model, 'surname')?>
				<?= $form->dropDownListRow($model, 'group_id',
					CHtml::listData(Group::model()->findAll(), 'id', function (Group $group) {
						return $group->name;
					}, function (Group $group) {
						return $group->institute->name;
					})
				)?>

				<?=$form->textFieldRow($model, 'username')?>
				<?=$form->passwordFieldRow($model, 'password')?>
				<?=$form->passwordFieldRow($model, 'password2')?>


				<?=$form->captchaRow($model, 'verifyCode', array('captchaOptions' => array(
					'buttonLabel' => 'Обновить')
				))
				?>


			</div>
		</div>
		<div class="row-fluid" style="margin-top: 50px">
			<div class="span6 offset3">
					<?$this->widget('bootstrap.widgets.TbButton', array(
						'buttonType'  => 'submit',
						'label' => 'Зарегистрироваться',
						'htmlOptions' => array('class' => 'btn-block btn-large btn btn-success ')))
					?>

			</div>
		</div>

	</fieldset>
	<? $this->endWidget()?>
</div>