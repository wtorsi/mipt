
<div class="row">
	<div class="login-form">
		<?
		/**
		 * @var $form TbActiveForm
		 * @var $this CController
		 * @var $model LoginForm
		 */
		$form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
			'id'            =>'login-form',
			'htmlOptions'   =>array('class'=>'well'),
		));
		echo $form->textFieldRow($model, 'username', array('class' => 'span12', 'maxlength' => 255));
		echo $form->passwordFieldRow($model, 'password', array('class' => 'span12', 'maxlength' => 255));
		$this->widget('bootstrap.widgets.TbButton', array('buttonType' => 'submit', 'label' => 'Войти'));
		$this->endWidget();
		?>
	</div>
</div>

