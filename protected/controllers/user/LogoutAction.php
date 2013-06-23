<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 20:46
 * To change this template use File | Settings | File Templates.
 */

class LogoutAction extends Action{
	public function run(){
		Yii::app()->user->logout(true);


		Request::redirect(Yii::app()->user->loginUrl);
	}
}