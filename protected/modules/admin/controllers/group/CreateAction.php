<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 10.06.13
 * Time: 22:53
 * To change this template use File | Settings | File Templates.
 */

class CreateAction extends Action {


	public function run(){

		$model = new Group();
		if($pdata = Request::post('Group')){
			$model->setAttributes($pdata);
			$model->save();
		}

		Request::goBack();
	}
}