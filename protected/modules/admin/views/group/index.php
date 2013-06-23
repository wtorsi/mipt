<?php
/* @var $this GroupController */
/* @var $dataProvider CActiveDataProvider */
/* @var $model Group */
/* @var $form TbActiveForm */
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
		<div class="span12" >
			<div class="alert alert-block">

				<? $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
					'id'=>'group-form',
					'type'=>'horizontal',
					'action' => Yii::app()->createUrl('/admin/group/create'),

				)); ?>
				<fieldset>
					<legend>Добавить группу</legend>

					<div class="row-fluid">
						<div class="span6">
							<?= $form->textFieldRow($model, 'name'); ?>
						</div>
						<div class="span6">
							<?= $form->dropDownListRow($model, 'institute_id',
								CHtml::listData(Institute::model()->findAll(), 'id', 'name'),
								array('empty' => 'Выбирете институт')
							);
							?>
						</div>
					</div>

				</fieldset>

				<div class="row-fluid">

					<? $this->widget('bootstrap.widgets.TbButton', array(
						'buttonType'=>'submit',
						'label'=>'Добавить группу',
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
				'enableSorting'     => false,
				'fixedHeader'       => true,
				'headerOffset'      => 40, // 40px is the height of the main navigation at bootstrap
				'type'              => 'striped bordered',
				'dataProvider'      => $dataProvider,
				'responsiveTable'   => true,
				'template'          => "{summary}{items}",
				'summaryText'       => "Количество разделов - {count}",
				'emptyText'         => 'Тут пока ничего нет',
				'columns'           => array(
					'id',
					array(
						'name'     => 'name',
						'class'    => 'bootstrap.widgets.TbEditableColumn',
						'editable' => array(
							'url'        => Yii::app()->createUrl('admin/group/update'),
							'placement'  => 'right',
						)
					),
					array(
						'name'     => 'institute_id',
						'value'     => '$data->institute->name',
						'class'    => 'bootstrap.widgets.TbEditableColumn',
						'editable' => array(
							'type'      => 'select',
							'url'        => Yii::app()->createUrl('admin/group/update'),
							'placement'  => 'right',
							'source'    => CHtml::listData(Institute::model()->findAll(), 'id', 'name'),
						)
					),
					'testsCount',
					array(
						'htmlOptions' => array('nowrap'=>'nowrap'),
						'class'=>'bootstrap.widgets.TbButtonColumn',
						'template' => "<div class='btn-group'> {delete}</div>",
						'buttons' => array(
							'delete' => array(
								'label' => 'Удалить',
								'options' => array('class' => 'btn btn-danger'),
								'url'       => '$data->getDeleteUrl()',
							)
						)
					)
				),
			));
			?>
		</div>
	</div>

</div>
