<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 01.06.13
 * Time: 14:29
 * To change this template use File | Settings | File Templates.
 */

class IndexAction extends Action {

	public function run(){
		$dataProvider   = new CActiveDataProvider('Branch');
		View::set('index',array(
			'dataProvider'  =>  $dataProvider,
		));
	}

}