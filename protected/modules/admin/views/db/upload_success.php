<?php
/**
 * @var $result array
 * @var $errors array
 */
?>
<div class="well">
	<h4>Результат выполнения</h4>
</div>

<? if (!empty($errors)): ?>
	<div class="alert alert-error">
		<h4>Ошибки в запросах</h4>
		<?foreach ($errors as $val):?>
			<a href="#query<?=$val?>"><?=$val?></a>
		<?endforeach?>
	</div>
<? endif ?>

<table class="table">

	<?foreach ($result as $key => $item): ?>

		<? if ($item['success']): ?>
			<tr class="success">
				<td>
					<a href="query<?=$key?>"></a>
					<?=$key?></td>
				<td>
					<p> <?=$item['shortQuery']?></p>
				</td>
			</tr>

		<? else: ?>
			<tr class="error">
				<td>
					<a name="query<?=$key?>"></a>
					<?=$key?>
				</td>
				<td>
					<p><?=$item['message']?></p>
				</td>
			</tr>

		<?endif ?>

	<? endforeach?>
</table>
