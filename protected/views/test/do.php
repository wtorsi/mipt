<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 22.06.13
 * Time: 15:17
 * To change this template use File | Settings | File Templates.
 */
/**
 * @var $question Question
 * @var $salt string
 * @var $test_id int
 * @var $result_id int
 */
?>

<div class="container-fluid">
	<div class="row-fluid">
		<div class="span3">
			<?=Tables::getHtml()?>
		</div>
		<div class="span9">
			<div class="row-fluid">
				<div class="span12">
					<div class="page-header">
						<h1><?=$question->branch->name?></h1>
						<blockquote>
							<p>
								Для ответа на вопрос введите команду SQL в поле <b>Ответ</b> <br/>
								Для проверки команды используйте кнопку <b>Проверить</b>, результат отобразится ниже <br/>
								Для ответа и перехода к следующему вопросу, используйте кнопку <b>Ответить</b> <br/>
								<br/>
								Доступные таблицы отображены слева. <br/>
								Для просмотра информации об интересующей Вас таблицы, кликните по ее названию
							</p>
						</blockquote>
					</div>
					<div class="row-fluid">
						<div class="span12">


							<div class="row-fluid body">
								<div class="span12">

									<form method="post" id="answer-form"
									      action="<?=Yii::app()->createUrl('/test/save')?>">
										<div class="alert alert-info alert-block">
											<h4><?=CHtml::encode($question->getAttributeLabel('question'))?></h4>
											<?=$question->question?>
										</div>
										<h4><?=CHtml::encode($question->getAttributeLabel('answer'))?> </h4>
										<textarea rows="6" name="Answer[answer]" id="inputAnswer"></textarea>
										<input type="hidden" name="Answer[salt]" value="<?=$salt?>">
										<input type="hidden" name="Answer[question_id]" value="<?=$question->id?>">
										<input type="hidden" name="Answer[result_id]" value="<?=$result_id?>">
										<input type="hidden" name="Answer[test_id]" value="<?=$test_id?>">
									</form>

								</div>
							</div>
							<div class="footer row-fluid">
								<div class="span12">
									<button class="btn btn-success" type="submit" form="answer-form">
										Ответить
									</button>
									<button class="btn btn-info" onclick="return checkCommand(this)"
										data-attr-url="<?=Yii::app()->createUrl('/test/check')?>">
										Проверить
									</button>


								</div>
							</div>
							<div class="row-fluid">
								<div class="span12" id="command-result">

								</div>
							</div>
						</div>
					</div>


				</div>
			</div>
		</div>
	</div>
</div>