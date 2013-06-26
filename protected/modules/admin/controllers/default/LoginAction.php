<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 25.05.13
 * Time: 7:02
 * To change this template use File | Settings | File Templates.
 */

class LoginAction extends CAction
{

	public function run() {

		$model = new LoginForm;
		if ($pdata = Request::post('LoginForm')) {
			$model->attributes = $pdata;
			if ($model->validate() and $model->login()) {
				Request::redirect(Yii::app()->user->returnUrl);
			}

		}
		View::set('login', array('model' => $model));
	}
}