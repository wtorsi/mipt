<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title><?=$this->pageTitle?></title>
	<?Yii::app()->bootstrap->register();?>
</head>

<body>

<div class="header">
	<div class="navbar navbar-inverse navbar-static-top">
		<div class="navbar-inner">

			<div class="container">

				<?=CHtml::link('MIPT SQL Benchmark', array('/index'), array('class' => 'brand'))?>
				<div class="pull-right">
					<?
					if(!Yii::app()->user->isGuest){
						echo CHtml::link('Выйти', array('/logout'), array('class' => 'brand'));
					}
					?>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="content">
	<div class="container-fluid">

		<div class="row-fluid">


			<div class="span12">
				<?=$content?>
			</div>


		</div>

	</div>
</div>


</body>
</html>