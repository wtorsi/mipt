<?
/**
 * @var $this CController
 */
?>
<div class="row-fluid">
	<div class="span3 tables">
		<div id="tables" data-attr-url="<?=Yii::app()->createUrl('/admin/db/tables')?>">

		<?=Tables::getHtml()?>
		</div>

	</div>
	<div class="span9">
		<div class="container-fluid">
			<div class="page-header">
				<h1>База Данных</h1>

				<div class="row-fluid">
					<div class="span12">
						<blockquote>
							<p>
								Загрузить *.sql скрипт.<br/>
								Вы можете указать префикс таблиц, если такой существует <br/>
							</p>
						</blockquote>
					</div>
				</div>
			</div>

			<div class="row-fluid form-inline">

				<div class="hidden">
					<input type="file" name="files" id="upload-input"
					       data-attr-url="<?=Yii::app()->createUrl('/admin/db/upload')?>">
				</div>

				<div class="span2">
					<button class="btn btn-success" id='upload-button'>
						<i class="icon-plus icon-white"></i>

						<span>Загрузить дамп...</span>
					</button>
				</div>




				<div class="span3">
					<label for="upload-prefix"> Префикс таблиц &nbsp; </label>
					<input id='upload-prefix' type="text" class="input-mini">
				</div>
			</div>


			<div class="row-fluid" style="margin-top: 40px">
				<div class="span11" id="upload-info">

					<h4>К загрузке</h4>
					<div class="row-fluid">
						<table class="table table-stripped">
							<tr>
								<td style="width: 40%">
									<h5 class="file-name">

									</h5>

									<div class="file-date">

									</div>
									<div class="file-error">

									</div>
								</td>
								<td style="width: 30%">
									<div class="text-right">
										<h5>Размер <span class="file-size"></span></h5>
									</div>


									<div class="text-center " id="upload-progress">
										<div class="progress progress-success progress-striped active" role="progressbar"
										     aria-valuemin="0" aria-valuemax="100">
											<div class="bar"  style="width:0%;"></div>
										</div>
									</div>
								</td>
								<td style="width: 5%">

									<button class="btn btn-primary btn-large" id="upload-submit">
										<i class="icon-upload icon-white"></i> <br/>
										<span>Выполнить</span>
									</button>

								</td>
							</tr>

						</table>
					</div>


				</div>

			</div>

			<div class="row-fluid">
				<div class="span12">
					<div id="upload-result">
					</div>
				</div>
			</div>


		</div>

	</div>
</div>