<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 11.06.13
 * Time: 13:43
 * To change this template use File | Settings | File Templates.
 */

class UpdateAction extends Action
{

	public function run() {

		$pk    = Request::post('pk');
		$name  = Request::post('name');
		$value = Request::post('value');
		/**
		 * @var $model Group
		 */
		if ($pk and $name and $value) {
			$model        = Group::model()->findByPk($pk);
			$model->$name = $value;
			if ($model->save()) {
				Yii::app()->end(200);
			}
		}
		Yii::app()->end(400);
	}
}