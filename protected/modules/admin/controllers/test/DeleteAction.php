<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 15:34
 * To change this template use File | Settings | File Templates.
 */

class DeleteAction extends Action{

	public function run($id){
		Test::model()->findByPk($id)->delete();
		Request::goBack();
	}
}