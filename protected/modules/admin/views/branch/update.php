<?php
/* @var $this BranchController */
/* @var $model Branch */

/**
 * @var $dataProvider CActiveDataProvider
 * @var $question Question
 */

?>

<div class="container-fluid">
	<div class="row-fluid">
		<div class="span3">
			<?=Tables::getHtml()?>
		</div>
		<div class="span9">
			<div class="page-header">
				<h1><?=CHtml::encode($model->getAttribute('name'))?></h1>
				<blockquote>
					<p>
						Редактируйте разделы<br/>
						Создавайте и удаляйте <br/>
					</p>
				</blockquote>

			</div>
			<div class="row-fluid">
				<div class="span12">


					<div class="row-fluid body">
						<div class="span4">

							<form method="post" id="question-form"
							      action="<?=Yii::app()->createUrl('/admin/question/create', array('branch_id' => $model->id))?>">
								<label for='inputQuestion'><?=CHtml::encode($question->getAttributeLabel('question'))?></label>
								<textarea class="span12" rows="6" name="Question[question]" id="inputQuestion"></textarea>
								<label for='inputAnswer'><?=CHtml::encode($question->getAttributeLabel('answer'))?> </label>
								<textarea class="span12" rows="6" name="Question[answer]" id="inputAnswer"></textarea>
							</form>

						</div>
						<div class="span8">
							<h4>Результат команды</h4>
							<div id="command-result">

							</div>
						</div>
					</div>
					<div class="footer row-fluid">
						<div class="span12">
							<button class="btn btn-success" type="submit" form="question-form">
								Добавить вопрос
							</button>
							<?=CHtml::ajaxButton('Проверить',
								Yii::app()->createUrl('/admin/question/check'),
								array(
									'type'      => 'post',
									'dataType'  => 'html',
									'data'      => 'js:getCommandData()',
									'success'   => 'js:setCommandResult',
								),
								array('class' => 'btn btn-info'))
							?>

						</div>
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
						'emptyText'         => 'Пока ничего нет',
						'dataProvider'      => $dataProvider,
						'template'          => "{summary}{items}",
						'summaryText'       => "Количество вопросов - {count}",
						'columns'           => array(
							'question',
							'answer',
							array(
								'name' => "Раздел",
								'value' => '$data->branch->name',
								'htmlOptions' => array('nowrap' => 'nowrap'),
							),
							array(
								'htmlOptions' => array('nowrap'=>'nowrap'),
								'class'=>'bootstrap.widgets.TbButtonColumn',
								'template' => "<div class='btn-group'>{update} {delete}</div>",
								'buttons' => array(
									'update' => array(
										'label'     => 'Редактировать',
										'options'   =>  array('class' => 'btn btn-success'),
//										'url'       => '$data->getUpdateUrl()',
										''
									),
									'delete' => array(
										'label' => 'Удалить',
										'options' => array('class' => 'btn btn-danger'),

									)
								)

							)

						),
					));
					?>
				</div>
			</div>
		</div>
	</div>

</div>
