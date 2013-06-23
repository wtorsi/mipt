<?php

class ErrorController extends Controller
{
	public function actionError() {
		if ($error = Yii::app()->errorHandler->error) {
			if (Yii::app()->request->isAjaxRequest) {
				echo $error['message'];
			}
			else {
				View::set('error', $error);
			}
		}
	}

	public function actionError404() {

		$this->render('error404');
	}
}