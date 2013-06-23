<?php
/**
 * @var $this QuestionController
 * @var $data Question
 */
?>

<div class="row-fluid">

	<div class="alert alert-info">
		<div class="row-fluid">
			<div class="span1">
				<b><?php echo CHtml::encode($data->getAttributeLabel('question')); ?>:</b>
			</div>
			<div class="span3">
				<?=CHtml::encode($data->question)?>
			</div>
			<div class="span1">
				<b><?php echo CHtml::encode($data->getAttributeLabel('answer')); ?>:</b>
			</div>
			<div class="span3">
				<?php echo CHtml::encode($data->answer); ?>
			</div>
			<div class="span1">
				<b><?php echo CHtml::encode($data->getAttributeLabel('branch')); ?>:</b>
			</div>
			<div class="span1">
				<?=CHtml::encode($data->branch->name)?>
			</div>
			<div class="pull-right">
				<a href="<?=Yii::app()->createUrl('admin/branch/update', array('id' => $data->id))?>" class="btn btn-success">
					<i class="icon-edit icon-white"></i>
				</a>
				<a href="<?=Yii::app()->createUrl('admin/branch/delete', array('id' => $data->id))?>" class="btn btn-danger">
					<i class="icon-remove icon-white"></i>
				</a>
				<?CHtml::link("<i class='icon-edit'></i>", array('update', 'id' => $data->id), array('class' => 'btn btn-success')) ?>
			</div>
		</div>
	</div>

</div>