<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 11.06.13
 * Time: 13:44
 * To change this template use File | Settings | File Templates.
 */

class DeleteAction extends Action{
	public function run($id){
		Group::model()->findByPk($id)->delete();
		Request::goBack();
	}
}