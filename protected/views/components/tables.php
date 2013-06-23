<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 02.06.13
 * Time: 18:55
 * To change this template use File | Settings | File Templates.
 */

/**
 * @var $tables array
 * @var $table CMysqlTableSchema
 * @var $column CMysqlColumnSchema Object
 */
?>
<div class="tables">
	<h4>Доступные таблицы</h4>

	<?foreach($tables  as $table):?>
		<div class="tables-parent">
			<a  href="#" onclick="return showTableDescription(this);">
				<?=$table->name?>
			</a>
			<div class="columns hidden">
				<table class="table table-bordered">
					<thead>
					<tr>
						<th>ID</th>
						<th>TYPE</th>
					</tr>
					</thead>
					<tbody>
					<?foreach( $table->columns as $column):?>
						<tr>
							<td> <?=$column->name?></td>
							<td> <?=$column->dbType?></td>
						</tr>
					<? endforeach ?>
					</tbody>
				</table>

			</div>
		</div>
	<?endforeach?>
</div>