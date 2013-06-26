<?php
/**
 * Created by JetBrains PhpStorm.
 * User: andreylukin
 * Date: 23.06.13
 * Time: 23:42
 * To change this template use File | Settings | File Templates.
 */

class ResultAction extends  Action{

	public function run($result_id){

		if( ! $model = Result::model()->findByPk($result_id) )
			Request::redirect('/');

		View::set('result', array('model' => $model));
	}
}