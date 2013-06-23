<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 17:18
 * To change this template use File | Settings | File Templates.
 */

class LoginAction extends Action{

	public function run(){

		$model = new LoginForm();

		if($pdata = Request::post('LoginForm')){
			$model->setAttributes($pdata);

			if ($model->validate() && $model->login()) {
				 Request::redirect('/');
			}
		}

		View::set('login', array('model' => $model));
	}
}