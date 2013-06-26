<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 23.06.13
 * Time: 16:34
 * To change this template use File | Settings | File Templates.
 */
/**
 * @var $query  string
 * @var $result array
 * @var $countRows int
 */
?>

<div class="span12">
	<h3>Результат запроса</h3>

	<div class="alert alert-success">
		<h3>Успешно</h3>
		<h4>Запрос</h4>
		<p><?=$query?></p>
		<h4>Количество строк</h4>
		<p><?=$countRows?></p>
		<h4>Результат</h4>
		<div class="result">

			<table class="table table-bordered table-condensed table-hovered">
				<thead>
				<tr>
					<?foreach ($result[0] as $key => $col): ?>
						<th> <?=$key?></th>
					<? endforeach?>
				</tr>
				</thead>
				<tbody>
				<?foreach ($result as $row): ?>
					<tr>
						<?foreach ($row as $col): ?>
							<td><?=$col?></td>
						<? endforeach?>
					</tr>
				<? endforeach?>
				</tbody>
			</table>

		</div>
	</div>
</div>
