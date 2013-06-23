<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<title><?=$this->pageTitle?></title>
</head>

<body>

<div class="header">
	<div class="navbar navbar-inverse navbar-static-top">
		<div class="navbar-inner">

			<div class="container">

				<?=CHtml::link('MIPT SQL Benchmark', array('/admin'), array('class' => 'brand'))?>

				<?
				/**
				 * @var $this CController
				 */

				if(!Yii::app()->user->isGuest){
					$this->widget('bootstrap.widgets.TbMenu',
						array(
							'type' => '',
							'items' => array(
								array('label' => 'База Данных', 'icon' => 'upload', 'url' => array('/admin/db')),

								array('label' => 'Тесты', 'icon' => 'pencil', 'url' => array('/admin/test')),
								array('label' => 'Разделы', 'icon' => 'pencil', 'url' => array('/admin/branch')),
								array('label' => 'Вопросы', 'icon' => 'edit', 'url' => array('/admin/question')),


									array('label' => 'Группы', 'icon' => 'edit', 'url' => array('/admin/group')),
									array('label' => 'Институты', 'icon' => 'edit', 'url' => array('/admin/institute')),



							)
						)
					);
				}
				?>

				<div class="pull-right">
					<?
					if(!Yii::app()->user->isGuest){
						echo CHtml::link('Выйти', array('/admin/logout'), array('class' => 'brand'));
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