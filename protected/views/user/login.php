<?
/**
 * @var $form TbActiveForm
 * @var $this CController
 * @var $model LoginForm
 */
?>
<div class="row">
	<div class="login-form">
		<?
		$form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
			'id'            =>'login-form',
			'htmlOptions'   =>array('class'=>'well'),

		));
		?>
		<?= $form->textFieldRow($model, 'username', array('class' => 'span12', 'maxlength' => 255)) ?>
		<?= $form->passwordFieldRow($model, 'password', array('class' => 'span12', 'maxlength' => 255)) ?>
		<? $this->widget('bootstrap.widgets.TbButton', array(
			'buttonType' => 'submit',
			'label' => 'Войти',
			'htmlOptions' => array('class' => 'btn-block'))
		);?>
		<?= CHtml::link('Зарегистрироваться', array('/register'), array('class' => 'btn-block btn btn-info'))?>

		<?$this->endWidget(); ?>

	</div>

</div>

