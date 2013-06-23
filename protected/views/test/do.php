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
								Редактируйте разделы<br/>
								Создавайте и удаляйте <br/>
							</p>
						</blockquote>

					</div>
					<div class="row-fluid">
						<div class="span12">


							<div class="row-fluid body">
								<div class="span4">

									<form method="post" id="question-form"
									      action="<?=Yii::app()->createUrl('')?>">
										<label for='inputQuestion'><?=CHtml::encode($question->getAttributeLabel('question'))?></label>
										<div class="span12 well">
											<?=$question->question?>
										</div>
										<label for='inputAnswer'><?=CHtml::encode($question->getAttributeLabel('answer'))?> </label>
										<textarea class="span12" rows="6" name="Question[answer]" id="inputAnswer"></textarea>
									</form>

								</div>
								<div class="span8">
									<h4>Результат команды</h4>
									<div id="command-result">

									</div>
								</div>
							</div>
							<div class="footer row-fluid">
								<div class="span12">
									<button class="btn btn-success" type="submit" form="question-form">
										Ответить
									</button>
									<?=CHtml::ajaxButton('Проверить',
										Yii::app()->createUrl('/test/check'),
										array(
											'type'      => 'post',
											'dataType'  => 'html',
											'data'      => 'js:getCommandData()',
											'success'   => 'js:setCommandResult',
										),
										array('class' => 'btn btn-info'))
									?>

								</div>
							</div>

						</div>
					</div>


				</div>
			</div>
		</div>
	</div>
</div>