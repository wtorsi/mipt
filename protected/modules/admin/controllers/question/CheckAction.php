<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 03.06.13
 * Time: 23:57
 * To change this template use File | Settings | File Templates.
 */

class CheckAction extends Action {

	public function run($command = null){

		/**
		 * @var $db CDbConnection
		 */
		$db =  Yii::app()->stable_db;
		$command = Request::post('command', '');

		try{
			$result = $db->createCommand($command)->queryAll(true);
		    View::parse('check_success', array('result' => $result, 'command' => $command), false);
		}
		catch(CDbException $e){
			$error = $e->errorInfo[2];
			View::parse('check_fail', array('error' => $error), false);
		}

		Yii::app()->end();
	}

}