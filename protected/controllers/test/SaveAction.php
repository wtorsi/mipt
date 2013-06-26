<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 21.06.13
 * Time: 23:10
 * To change this template use File | Settings | File Templates.
 */

class SaveAction extends Action {

	public function run(){
		if($pdata = Request::post('Answer')){
			$model = new Answer();
			$model->setAttributes($pdata);
			if($model->validate() and $model->save(false)){
				Request::goBack();
			}
		}
		Request::redirect('/');
	}
}