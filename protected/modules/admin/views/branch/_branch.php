<?php
/**
 * @var $this BranchController
 * @var $data Branch
 */
?>

<div class="row-fluid">

	<div class="alert alert-info">
		<div class="row-fluid">
			<div class="span1">
				<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
			</div>
			<div class="span1">
				<?=CHtml::encode($data->id)?>
			</div>
			<div class="span1">
				<b><?php echo CHtml::encode($data->getAttributeLabel('name')); ?>:</b>
			</div>
			<div class="span3">
				<?php echo CHtml::encode($data->name); ?>
			</div>
			<div class="span1">
				Кол-во вопросов
			</div>
			<div class="span1">
				<?=CHtml::encode($data->questionsCount)?>
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