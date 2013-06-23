<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 23:11
 * To change this template use File | Settings | File Templates.
 */
/**
 * @var $user User
 * @var $test Test
 */
?>
<div class="container-fluid">
	<div class="span10 offset2">
		<div class="page-header">
			<h3>
				<?= $user->group->name . " " . $user->group->institute->name . " | " . $user->name . " " . $user->surname ?>
			</h3>
		</div>
		<div class="row-fluid">
			<div class="span4">
				<h4>Доступные тесты</h4>

				<table class="table table-bordered table-hover table-condensed">
					<tr>
						<th class="span3">Название</th>
						<th class="span4">Количество вопросов</th>
						<th></th>
					</tr>
					<? foreach ($user->group->tests as $test): ?>
						<tr>
							<td><?=$test->name?></td>
							<td><?=$test->question_count?></td>
							<td>
								<?=CHtml::link('Начать', array('/test/do', 'test_id' => $test->id), array('class' => 'btn btn-success'))?>
							</td>
						</tr>
					<? endforeach ?>
				</table>

			</div>
			<div class="span7 offset1">
				<h4>Пройденные тесты</h4>
				<table class="table table-bordered table-hover table-condensed">
					<tr>
						<th class="span3">Название</th>
						<th class="span3">Кол-во <br/> вопросов</th>
						<th class="span3">Правильно <br/> отвеченных</th>
						<th class="span2"></th>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>