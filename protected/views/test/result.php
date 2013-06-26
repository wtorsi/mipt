<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 23.06.13
 * Time: 23:43
 * To change this template use File | Settings | File Templates.
 */
/**
 * @var $model Result
 * @var $answer Answer
 */
?>


<div class="container">
	<div class="row">
		<div class="span12">
			<div class="page-header">
				<div class="row-fluid">
					<div class="span6">
						<h1><?=$model->test->name?> </h1>
						<h3><?=$model->test->branch->name?></h3>
					</div>
					<div class="span6 text-right">
						<h1><?=User::get()->name?> <?=User::get()->surname?></h1>
						<h3><?=User::get()->group->name?> <?=User::get()->group->institute->name?></h3>
					</div>
				</div>

			</div>

		</div>

	</div>
	<div class="row text-right">
		<div class="span12">
			<blockquote>
				<h3>
					Ваш результат
					<?= ceil(100 * ($model->answered_right / $model->answered)
						* ($model->answered/$model->test->question_count) ) . '%'?>
				</h3>
				<? if($model->answered==$model->test->question_count): ?>
					<? if($model->answered_right == $model->answered): ?>
						<p>
							<span class="label label-success">Пройдено</span> <br/>
							Вы успешно прошли тест, возможно в будущем вы будете великим программистом
						</p>
					<? else: ?>
						<p>
							<span class="label label-important">С ошибками</span> <br/>
							Увы, в тесте допущены ошибки, попробуйте еще раз <br/>

						</p>
					<? endif?>
				<? else: ?>
					<p>
						<span class="label label-warning">В процессе</span> <br/>
						Вы уже гораздо ближе к цели, продолжайте в том же духе и Вы добъетесь много.
					</p>
				<? endif?>

			</blockquote>
		</div>
	</div>
	<div class="row">
		<div class="span12 ">


		</div>
	</div>
	<div class="row">

		<div class="span12">
			<h4>Суммарный отчет</h4>
			<table class="table table-bordered">
				<tr>
					<th>Дата начала</th>
					<td><?=$model->start_time?></td>

				</tr>
				<tr>
					<th>Дата окончания</th>
					<td><?=$model->end_time?></td>
				</tr>
				<tr>
					<th>Кол-во вопросов в тесте</th>
					<td><?=$model->test->question_count?></td>
				</tr>
				<tr>
					<th>Кол-во данных ответов</th>
					<td><?=$model->answered?></td>
				</tr>
				<tr>
					<th>Кол-во правильно данных ответов</th>
					<td><?=$model->answered_right?></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="span12">

			<h4>Ваши ответы</h4>
			<table class="table table-hovered table-bordered">
				<thead>
					<tr>
						<th>Вопрос</th>
						<th>Ответ</th>
						<th></th>
					</tr>
				</thead>

				<?foreach ($model->answers as $answer): ?>
					<? if($answer->is_right):?>
						<tr class="success">
							<td><?=$answer->question->question?></td>
							<td><?=$answer->answer?></td>
							<td>Правильно</td>
						</tr>
					<? else: ?>
						<tr class="error">
							<td><?=$answer->question->question?></td>
							<td><?=$answer->answer?></td>
							<td>Не правильно</td>
						</tr>
					<? endif?>


				<?endforeach?>

			</table>

		</div>
	</div>
</div>