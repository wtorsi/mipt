<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 04.06.13
 * Time: 23:30
 * To change this template use File | Settings | File Templates.
 */

class IndexAction extends Action
{

	public function run() {

		$dataProvider = new CActiveDataProvider('Test');
		$model        = new Test();

		$data = array(
			'dataProvider' => $dataProvider,
			'model'        => $model
		);

		View::set('index', $data);
	}
}