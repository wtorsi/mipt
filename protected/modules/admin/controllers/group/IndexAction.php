<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 10.06.13
 * Time: 20:23
 * To change this template use File | Settings | File Templates.
 */

class IndexAction extends Action
{

	public function run() {
		$dataProvider = new CActiveDataProvider('Group');
		$model        = new Group();

		$data = array(
			'dataProvider' => $dataProvider,
			'model'        => $model,
		);
		View::set('index', $data);
	}

}