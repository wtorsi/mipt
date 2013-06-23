<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 01.06.13
 * Time: 14:31
 * To change this template use File | Settings | File Templates.
 */

class DeleteAction extends Action{

	public function run($id){
		Branch::model()->findByPk($id)->delete();
		Yii::app()->end();
	}
}