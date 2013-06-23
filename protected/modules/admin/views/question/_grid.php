<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 02.06.13
 * Time: 23:51
 * To change this template use File | Settings | File Templates.
 */
/**
 * @var $question Question
 * @var $dataProvider CActiveDataProvider
 */
?>

<table class="table table-bordered table-hover">
	<thead>
		<tr>
			<th>
				<?=CHtml::encode( Question::model()->getAttributeLabel('question') )?>
			</th>
			<th>
				<?=CHtml::encode(Question::model()->getAttributeLabel('answer'))?>
			</th>
			<th>
				<?=CHtml::encode(Question::model()->getAttributeLabel('branch'))?>
			</th>
			<th>
				&nbsp;
			</th>
		</tr>
	</thead>
	<tbody>
		<?foreach($dataProvider->getData() as $question):?>
			<tr>
				<td>
					<?=CHtml::encode($question->question)?>
				</td>
				<td>
					<?=CHtml::encode($question->answer)?>
				</td>
				<td>
					<?=CHtml::encode($question->branch->name)?>
				</td>
				<td>

				</td>
			</tr>
		<?endforeach?>
	</tbody>
</table>