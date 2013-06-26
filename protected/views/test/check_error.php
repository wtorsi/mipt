<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 23.06.13
 * Time: 16:34
 * To change this template use File | Settings | File Templates.
 */
/**
 * @var $query string
 * @var $error string
 */
?>

<div class="span12">
	<h3>Результат запроса</h3>

	<div class="alert alert-danger">
		<h3>Ошибка</h3>
		<h4>Запрос</h4>
		<p><?=$query?></p>
		<h4>Ответ MySQL</h4>
		<p><?=$error?></p>
	</div>
</div>
