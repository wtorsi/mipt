<?php
/* @var $this BranchController */
/* @var $dataProvider CActiveDataProvider */
/* @var $model Test */
/* @var $form TbActiveForm */

?>

<div class="container">
	<div class="page-header">
		<h1>Тесты</h1>
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
					'id'=>'test-form',
					'type'=>'horizontal',
					'action' => Yii::app()->createUrl('/admin/test/create'),

				)); ?>
				<fieldset>
					<legend>Добавить группу</legend>

					<div class="row-fluid">
						<div class="span6">
							<?= $form->textFieldRow($model, 'name'); ?>
						</div>
						<div class="span6">
							<?= $form->dropDownListRow($model, 'groups',
								CHtml::listData(Group::model()->findAll(), 'id', 'name'),
								array('multiple' => true)
							)?>
						</div>
					</div>
					<div class="row-fluid">
						<div class="span6">
							<?= $form->dropDownListRow($model, 'branch_id',
								CHtml::listData(Branch::model()->findAll(), 'id', function(Branch $branch){
									return $branch->name . " (" . $branch->questionsCount . ")";
								}),
								array('empty' => 'Выбирете раздел')
							);
							?>
						</div>
						<div class="span6">
							<?= $form->textFieldRow($model, 'question_count'); ?>
						</div>
					</div>

				</fieldset>

				<div class="row-fluid">

					<? $this->widget('bootstrap.widgets.TbButton', array(
						'buttonType'=>'submit',
						'label'=>'Добавить тест',
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
				'emptyText'         => "Пока ничего нет",
				'responsiveTable'   => true,
				'template'          => "{summary}{items}",
				'summaryText'       => "Количество тестов - {count}",
				'columns'           => array(
					'id',
					array(
						'name'     => 'name',
						'class'    => 'bootstrap.widgets.TbEditableColumn',
						'editable' => array(
							'url'        => Yii::app()->createUrl('admin/test/update'),
							'placement'  => 'right',
						)
					),
					array(
						'name'     => 'question_count',
						'class'    => 'bootstrap.widgets.TbEditableColumn',
						'editable' => array(
							'url'        => Yii::app()->createUrl('admin/test/update'),
							'placement'  => 'right',
						)
					),
					array(
						'name'     => 'branch_id',
						'value'     => '$data->branch->name',
						'class'    => 'bootstrap.widgets.TbEditableColumn',
						'editable' => array(
							'type'      => 'select',
							'url'        => Yii::app()->createUrl('admin/test/update'),
							'placement'  => 'right',
							'source'    => CHtml::listData(Branch::model()->findAll(), 'id', 'name'),
						)
					),


					array(
						'htmlOptions' => array('nowrap'=>'nowrap'),
						'class'=>'bootstrap.widgets.TbButtonColumn',
						'template' => "<div class='btn-group'>{delete}</div>",
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
