<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 01.06.13
 * Time: 17:00
 * To change this template use File | Settings | File Templates.
 */

class CreateAction extends Action
{

	public function run($branch_id) {
		$model            = new Question();
		$model->branch_id = $branch_id;

		if ($pdata = Request::post('Question')) {
			$model->setAttributes($pdata);

			if ($model->validate() and  $model->save()) {
				Yii::app()->user->setFlash('success', "Вопрос успешно создан");
			}
		}


		Request::redirect(array('/admin/branch/update', 'id' => $branch_id));

	}
}