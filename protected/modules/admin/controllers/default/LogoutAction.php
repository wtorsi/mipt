<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 25.05.13
 * Time: 7:05
 * To change this template use File | Settings | File Templates.
 */

class LogoutAction extends CAction{

	public function run(){
		Yii::app()->user->logout(false);
		Request::redirect(Yii::app()->createUrl( Yii::app()->user->loginUrl ));

	}
}