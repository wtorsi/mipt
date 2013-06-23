<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 12.06.13
 * Time: 12:50
 * To change this template use File | Settings | File Templates.
 */

class CreateAction extends Action
{
	public function run() {

		$model = new Test();
		if ($pdata = Request::post("Test")) {
			$model->setAttributes($pdata);

			if (isset($pdata['groups'])) {
				$model->groups = $pdata['groups'];
			}

			$model->save();
		}
		Request::redirect('/admin/test');
	}
}