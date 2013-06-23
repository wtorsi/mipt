<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 11.06.13
 * Time: 13:38
 * To change this template use File | Settings | File Templates.
 */

class IndexAction extends Action
{

	public function run() {
		$dataProvider = new CActiveDataProvider('Institute');

		$model = new Institute();
		$data  = array(
			'dataProvider' => $dataProvider,
			'model'        => $model,
		);
		View::set('index', $data);
	}
}