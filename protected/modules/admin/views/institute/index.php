<?php
/* @var $this InstituteController */
/* @var $dataProvider CActiveDataProvider */
/* @var $model Institute */
/* @var $form TbActiveForm */
/* @var $data Institute */
?>

<div class="container">
	<div class="page-header">
		<h1>Группы и Институты</h1>
		<blockquote>
			<p>
				Редактируйте разделы<br/>
				Создавайте и удаляйте <br/>
			</p>
		</blockquote>
	</div>

	<div class="row-fluid">
		<div class="span12">
			<div class="alert alert-block">

				<? $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
					'id'     => 'institute-form',
					'type'   => 'horizontal',
					'action' => Yii::app()->createUrl('/admin/institute/create'),
				));
				?>
				<fieldset>
					<legend>Добавить институт</legend>

					<div class="row-fluid">
						<div class="span6">
							<?= $form->textFieldRow($model, 'name'); ?>
						</div>

					</div>

				</fieldset>

				<div class="row-fluid">

					<? $this->widget('bootstrap.widgets.TbButton', array(
						'buttonType'  => 'submit',
						'label'       => 'Добавить институт',
						'htmlOptions' => array('class' => 'btn btn-success span12 ')
					));
					?>
				</div>


				<? $this->endWidget(); ?>
			</div>
		</div>

	</div>


	<div class="row-fluid">
		<div class="span12">
			<? $this->widget('bootstrap.widgets.TbExtendedGridView', array(
				'enableSorting'   => false,
				'fixedHeader'     => true,
				'headerOffset'    => 40, // 40px is the height of the main navigation at bootstrap
				'type'            => 'striped bordered',
				'dataProvider'    => $dataProvider,
				'responsiveTable' => true,
				'template'        => "{summary}{items}",
				'summaryText'     => "Количество институтов - {count}",
				'emptyText'       => 'Тут пока ничего нет',
				'columns'         => array(
					'id',
					array(
						'name'     => 'name',
						'class'    => 'bootstrap.widgets.TbEditableColumn',
						'editable' => array(
							'url'        => Yii::app()->createUrl('admin/institute/update'),
							'placement'  => 'right',
							'text'       => ''

						)
					),
					array(
						'name'  => 'groups',
						'value' => '$data->getGroupsList()',
					),
					array(
						'htmlOptions' => array('nowrap' => 'nowrap'),
						'class'       => 'bootstrap.widgets.TbButtonColumn',
						'template'    => "<div class='btn-group'>{delete}</div>",
						'buttons'     => array(

							'delete' => array(
								'label'   => 'Удалить',
								'options' => array('class' => 'btn btn-danger'),
								'url'     => '$data->getDeleteUrl()',
							)
						)

					)

				),
			));
			?>
		</div>
	</div>

</div>
