<?php
/* @var $this BranchController */
/* @var $dataProvider CActiveDataProvider */
?>

<div class="container">
	<div class="page-header">
		<h1>Разделы</h1>
		<blockquote>
			<p>
				Редактируйте разделы<br/>
				Создавайте и удаляйте <br/>
			</p>
		</blockquote>
	</div>

	<div class="row-fluid">
		<div class="span12">
			<form class="form form-inline" action="<?=Yii::app()->createUrl('/admin/branch/create')?>" method="post">
				<label>
					Название раздела <input type="text" value="" name="Branch[name]">
				</label>
				<button class="btn btn-success " type="submit">
					Создать
				</button>
			</form>
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
				'columns'           => array(
					'id',
					'name',
					array(
						'name' => "Количество вопросов",
						'value' => '$data->questionsCount',
					),
					array(
						'htmlOptions' => array('nowrap'=>'nowrap'),
						'class'=>'bootstrap.widgets.TbButtonColumn',
						'template' => "<div class='btn-group'>{update} {delete}</div>",
						'buttons' => array(
							'update' => array(
								'label'     => 'Редактировать',
								'options'   =>  array('class' => 'btn btn-success'),
								'url'       => '$data->getUpdateUrl()',

							),
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
