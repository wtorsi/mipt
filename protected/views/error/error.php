<?php
/* @var $this ErrorController */

//$this->breadcrumbs=array(
//	'Error'=>array('/error'),
//	'Error',
//);
?>

<h2>Error <?php echo $code; ?></h2>

<div class="error">
	<?php echo CHtml::encode($message); ?>
</div>