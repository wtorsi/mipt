<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 04.06.13
 * Time: 0:09
 * To change this template use File | Settings | File Templates.
 */
/**
 * @var $result array
 * @var $this   QuestionController
 * @var $command string
 */
?>
<div class="alert alert-success alert-block">
	<h4>SQL Success</h4>
	<p><?=$command?></p>
</div>
<? if ($result): ?>
<table class="table table-bordered">
	<tr>
		<? foreach ($result[0] as $name => $col) : ?>
			<th><?=$name?></th>
		<? endforeach ?>
	</tr>
	<? foreach($result as $row):?>
		<tr>
			<? foreach($row as $col):?>
				<td><?=$col?></td>
			<?endforeach?>
		</tr>
	<? endforeach ?>
</table>
<?else:?>
<h3>Запрос вернул пустой результат</h3>
<?endif?>