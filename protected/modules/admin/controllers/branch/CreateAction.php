<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 01.06.13
 * Time: 17:00
 * To change this template use File | Settings | File Templates.
 */

class CreateAction extends Action {

	public function run(){
		$model=new Branch;

		if($pdata = Request::post('Branch')){
			$model->attributes = $pdata;
			$model->save();
		}
		Request::goBack();
	}
}